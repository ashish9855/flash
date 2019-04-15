//
//  VehicleDetailsModelTests.swift
//  FlashTests
//
//  Created by Ashish Maheshwari on 14.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import XCTest
@testable import Flash

class VehicleDetailsModelTests: XCTestCase {
    
    func testVehicleDetailsData_WhenDataParsed() {
        guard let data = readJSONData("vehicleDetails") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: Throwable<VehicleDetails>.self)
        switch parsed {
        case .success(let vehicleDetails):
            guard let vehicle = vehicleDetails.value else {
                assertionFailure()
                return
            }
            XCTAssertEqual(vehicle.id, 1)
            XCTAssertEqual(vehicle.name, "000011")
            XCTAssertEqual(vehicle.description, "Electric Scooter")
            XCTAssertEqual(vehicle.latitude, 52.529077)
            XCTAssertEqual(vehicle.longitude, 13.416351)
            XCTAssertEqual(vehicle.batteryLevel, 98)
            XCTAssertEqual(vehicle.timestamp, "2019-03-10T09:31:56Z")
            XCTAssertEqual(vehicle.price, 15)
            XCTAssertEqual(vehicle.priceTime, 60)
            XCTAssertEqual(vehicle.currency, "€")
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }

    func test_whenVehicleDetailsJsonParsedIdNull_thenRemoveObject() {
        guard let data = readJSONData("vehicleDetailsIdNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: Throwable<VehicleDetails>.self)
        switch parsed {
        case .success(let vehicleDetails):
            XCTAssertNil(vehicleDetails.value)
        case .error(let error):
            XCTAssertNotNil(error)

        }
    }
    
    func test_whenVehicleDetailsJsonParsedNameNull_thenRemoveObject() {
        guard let data = readJSONData("vehicleDetailsNameNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: Throwable<VehicleDetails>.self)
        switch parsed {
        case .success(let vehicleDetails):
            XCTAssertNil(vehicleDetails.value)
        case .error(let error):
            XCTAssertNotNil(error)
            
        }
    }
    
    func test_whenVehicleDetailsJsonParsedCurrencyNull_thenRemoveObject() {
        guard let data = readJSONData("vehicleDetailsCurrencyNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: Throwable<VehicleDetails>.self)
        switch parsed {
        case .success(let vehicleDetails):
            XCTAssertNil(vehicleDetails.value)
        case .error(let error):
            XCTAssertNotNil(error)
            
        }
    }
    
    func test_whenVehicleDetailsJsonParsedPriceNull_thenRemoveObject() {
        guard let data = readJSONData("vehicleDetailsPriceNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: Throwable<VehicleDetails>.self)
        switch parsed {
        case .success(let vehicleDetails):
            XCTAssertNil(vehicleDetails.value)
        case .error(let error):
            XCTAssertNotNil(error)
            
        }
    }
    
}
