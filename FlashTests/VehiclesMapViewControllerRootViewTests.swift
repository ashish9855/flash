//
//  VehiclesMapViewControllerRootViewTests.swift
//  FlashTests
//
//  Created by Ashish Maheshwari on 14.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import XCTest
import MapKit
@testable import Flash

class VehiclesMapViewControllerRootViewTests: XCTestCase {
    
    var oldVehicles: [Vehicle]?
    var newVehicles: [Vehicle]?
    let mapViewRootView = VehiclesMapViewControllerRootView()

    override func setUp() {
        super.setUp()
        guard let oldVehiclesData = readJSONData("vehiclesOld"), let newVehiclesData = readJSONData("vehiclesNew") else {
            assertionFailure()
            return
        }
        let oldParsed = ResponseParser.parsedResponse(oldVehiclesData, type: [Throwable<Vehicle>].self)
        switch oldParsed {
        case .success(let value):
            let vehicles = value.compactMap({$0.value})
            oldVehicles = vehicles
        default:
            assertionFailure()
        }

        let newParsed = ResponseParser.parsedResponse(newVehiclesData, type: [Throwable<Vehicle>].self)
        switch newParsed {
        case .success(let value):
            let vehicles = value.compactMap({$0.value})
            newVehicles = vehicles
        default:
            assertionFailure()
        }
    }

    func testGetAnotation_WhenVehicleObjectPassed() {
        guard let vehicle = oldVehicles?[0] else { return }
        let anotation = mapViewRootView.getAnnotation(vehicle: vehicle)
        XCTAssertEqual(vehicle.latitude, anotation.coordinate.latitude)
        XCTAssertEqual(vehicle.longitude, anotation.coordinate.longitude)
        XCTAssertEqual(String(vehicle.id), anotation.title)
    }

    func testConvertCoordinatesToAnnotations_WhenVehicleObjectPassed_ThenConvertToAnotation() {
        guard let vehicle = oldVehicles?[1] else { return }
        let anotation = mapViewRootView.convertCoordinatesToAnnotations(for: [vehicle])
        let object = anotation[0]
        XCTAssertEqual(vehicle.latitude, object.coordinate.latitude)
        XCTAssertEqual(vehicle.longitude, object.coordinate.longitude)
        XCTAssertEqual(String(vehicle.id), object.title)
    }

    func testCommonVehicles_WhenOldAndNewReceivedVehiclesPassed_ThenReturnCommon() {
        let old = oldVehicles ?? []
        let new = newVehicles ?? []
        let commonVehicles = mapViewRootView.commonVehicles(between: old, and: new)
        XCTAssertEqual(commonVehicles.count, 1)
    }

    func testLeftVehicles_WhenCommonAndAllVehiclesPassed_ThenReturnLeftOnes() {
        let old = oldVehicles ?? []
        let new = newVehicles ?? []
        let commonVehicles = mapViewRootView.commonVehicles(between: old, and: new)
        let leftVehicles = mapViewRootView.leftVehicles(in: old, after: commonVehicles)
        XCTAssertEqual(leftVehicles.count, 5)
    }

    func testGetAnotations_WhenVehiclesAndAnotationsPassed_ThenReturnAnotationsThatMatchesVehicles() {
        let old = oldVehicles ?? []

        let annotation = MKPointAnnotation()
        let latitude = CLLocationDegrees(52.529077)
        let longitude = CLLocationDegrees(13.416351)
        let coordinates = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude)
        annotation.title = "000011"
        annotation.coordinate = coordinates

        let vehicles = mapViewRootView.getAnotations(in: [annotation], of: old)
        XCTAssertEqual(vehicles.count, 1)
    }
}
