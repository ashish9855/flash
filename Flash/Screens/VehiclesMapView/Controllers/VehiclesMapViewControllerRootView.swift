//
//  VehiclesMapViewControllerRootView.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import UIKit
import MapKit
import MBProgressHUD

class VehiclesMapViewControllerRootView: UIView {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var vehicleDetailsContainerView: UIView!

    let vehicleDetailView: VehicleView = VehicleView.fromNib()
    var mapLoadedOnce: Bool = false
    var vehicles: [Vehicle] = []
    var annotations:[MKPointAnnotation] = []

    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp(on controller: UIViewController) {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to show vehicles near you we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func handle(oldVehicles: [Vehicle], newVehicles: [Vehicle], oldAnotations:[MKPointAnnotation]) -> (vehicles: [Vehicle], anotations: [MKPointAnnotation]) {
        
        // if we dont have vehicles already
        guard !oldVehicles.isEmpty else {
            let newAnotations = convertCoordinatesToAnnotations(for: newVehicles)
            addAnotationsOnMap(newAnotations)
            return (vehicles: newVehicles, anotations: newAnotations)
        }
        
        // find common vehicles between latest vehicles and old ones
        let common = commonVehicles(between: oldVehicles, and: newVehicles)
        
        // find remaing old vehicles after removing common ones
        let remainingOldVehicles = leftVehicles(in: oldVehicles, after: common)
        
        // find remaing new vehicles after removing common ones
        let remainingNewVehicles = leftVehicles(in: newVehicles, after: common)
        
        // remove old anotations of vehicles which are not there in new ones
        let annotationsToBeRemoved = getAnotations(in: oldAnotations, of: remainingOldVehicles)
        
        // remove anotations
        removeAnotationsFromMap(annotationsToBeRemoved)
        let leftAnotations = removeAnotations(annotationsToBeRemoved, from: oldAnotations)
        
        // new vehicles anotations to be added
        let newAnotations = convertCoordinatesToAnnotations(for: remainingNewVehicles)
        addAnotationsOnMap(newAnotations)
        
        // final vehicles in the list
        let finalVehicles = common + remainingNewVehicles
        let finalAnotations = newAnotations + leftAnotations
        
        return (vehicles: finalVehicles, anotations: finalAnotations)
    }
    
    func addAnotationsOnMap(_ anotations: [MKPointAnnotation]) {
        mapView.addAnnotations(anotations)
    }
    
    func removeAnotationsFromMap(_ anotations: [MKPointAnnotation]) {
        for anotation in anotations {
            mapView.removeAnnotation(anotation)
        }
    }
    
    func removeAnotations(_ anotations: [MKPointAnnotation], from old: [MKPointAnnotation]) -> [MKPointAnnotation] {
        var oldAnotation = old
        for anotation in anotations {
            if let index = oldAnotation.index(where: { $0.title == anotation.title }), index < old.count {
                oldAnotation.remove(at: index)
            }
        }
        return oldAnotation
    }
    
    func commonVehicles(between old: [Vehicle], and new: [Vehicle]) -> [Vehicle] {
        return new.filter { old.contains($0) }
    }
    
    func leftVehicles(in vehicles: [Vehicle], after common: [Vehicle]) -> [Vehicle] {
        return vehicles.filter{ !common.contains($0) }
    }
    
    func getAnotations(in anotations:[MKPointAnnotation], of vehicles: [Vehicle]) -> [MKPointAnnotation] {
        return anotations.filter { (anotation) -> Bool in
            return vehicles.contains(where: { $0.name == anotation.title })
        }
    }
    
    func convertCoordinatesToAnnotations(for vehicles: [Vehicle]) -> [MKPointAnnotation] {
        var tempAnnotations:[MKPointAnnotation] = []
        for vehicle in vehicles {
            let annotation = getAnnotation(vehicle: vehicle)
            tempAnnotations.append(annotation)
        }
        return tempAnnotations
    }
    
    func removeAllAnotations() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    func addAllAnotations() {
        if !annotations.isEmpty {
            removeAllAnotations()
            mapView.addAnnotations(annotations)
        }
    }
    
    func getAnnotation(vehicle: Vehicle) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        let latitude = vehicle.latitude
        let longitude = vehicle.longitude
        let coordinates = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        annotation.title = String(vehicle.id)
        annotation.coordinate = coordinates
        return annotation
    }
    
    func startLoading() {
        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func stopLoading() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func zoomMap() {
        guard !mapLoadedOnce,
        let firstCoordinate = annotations.first?.coordinate,
        let lastCoordinate = annotations.last?.coordinate else {
            return
        }
        mapLoadedOnce = true
        var zoomRect = MKMapRectNull
        let firstAnnotationPoint = MKMapPointForCoordinate(firstCoordinate);
        let firstPointRect = MKMapRectMake(firstAnnotationPoint.x, firstAnnotationPoint.y, 0.1, 0.1);
        
        let lastAnnotationPoint = MKMapPointForCoordinate(lastCoordinate);
        let lastPointRect = MKMapRectMake(lastAnnotationPoint.x, lastAnnotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(firstPointRect, lastPointRect)
        mapView.setVisibleMapRect(zoomRect, animated: true)
    }
    
    func getVehicle(from vehicles: [Vehicle], with id: Int) -> Vehicle? {
        return vehicles.first(where: {$0.id == id })
    }
    
    private func addVehicleView() {
        vehicleDetailView.translatesAutoresizingMaskIntoConstraints = false
        vehicleDetailsContainerView.addSubview(vehicleDetailView)
        vehicleDetailView.addConstraintToEdges(to: vehicleDetailsContainerView)
    }
    
    func showDetailView(for vehicle: Vehicle, delegate: VehiclesMapViewController) {
        addVehicleView()
        vehicleDetailView.setup(presentationModel: VehicleViewPresentationModel(vehicle: vehicle), delegate: delegate)
        vehicleDetailsContainerView.isHidden = false
    }

    func hideVehicleDetailsView() {
        vehicleDetailView.removeFromSuperview()
        vehicleDetailsContainerView.isHidden = true
    }
}
