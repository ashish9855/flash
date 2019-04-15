//
//  VehiclesMapViewController.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import UIKit
import MapKit

class VehiclesMapViewController: BaseViewController, RootViewProtocol {

    typealias TypeRootView = VehiclesMapViewControllerRootView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsNavigationBar = false
        rootView.startLoading()
        getVehicles()
    }
    
    func getVehicles() {
        businessLayer.vehicles {[weak self] result in
            self?.rootView.stopLoading()
            switch result {
            case .success(let vehicles):
                self?.handleVehicles(vehicles)
                self?.fireTimer()
            case .error(let error):
                self?.fireTimer()
                print(error.description)
            }
        }
    }

    func fireTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.getVehicles()
        }
    }
    
    func handleVehicles(_ vehicles: [Vehicle]) {
        let oldVehicles = self.rootView.vehicles
        let oldAnotations = self.rootView.annotations
        let (finalVehicles, finalAnotations) = self.rootView.handle(oldVehicles: oldVehicles, newVehicles: vehicles, oldAnotations: oldAnotations)
        self.rootView.vehicles = finalVehicles
        self.rootView.annotations = finalAnotations
        self.rootView.zoomMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension VehiclesMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pinView: MKPinAnnotationView?
        let defaultPinID = "myAnnotation"
        
        pinView = mapView.dequeueReusableAnnotationView(withIdentifier: defaultPinID) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: defaultPinID)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let selectedAnotation = view.annotation as? MKPointAnnotation
        guard let id = selectedAnotation?.title, let identifier = Int(id) else { return }
        guard let vehicle = rootView.getVehicle(from: rootView.vehicles, with: identifier) else { return }
        rootView.showDetailView(for: vehicle, delegate: self)
    }
}

extension VehiclesMapViewController: VehicleViewProtocol {
    func close() {
        rootView.hideVehicleDetailsView()
    }
    
    func showDetails(for vehicle: Int) {
        close()
        VehicleDetailsViewController.present(on: self, input: VehicleDetailsViewController.Input(vehicleId: vehicle))
    }
}
