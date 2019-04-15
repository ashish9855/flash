//
//  VehicleModelTests.swift
//  FlashTests
//
//  Created by Ashish Maheshwari on 14.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import XCTest
@testable import Flash

class VehiclesModelTest: XCTestCase {
    
    func testItemsCount_WhenDataParsed() {
        guard let data = readJSONData("vehicles") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 2)
        default:
            assertionFailure()
        }
    }
    
    func testVehicleData_WhenDataParsed() {
        guard let data = readJSONData("vehicles") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            let vehicle = vehicles[0]
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
            XCTAssertEqual(vehicles.count, 2)
        default:
            assertionFailure()
        }
    }
    
    func test_whenVehiclesListJsonParsedIdNull_thenRemoveObject() {
        guard let data = readJSONData("vehiclesIdNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 1)
            let object = vehicles[0]
            XCTAssertEqual(object.id, 1)
            XCTAssertEqual(object.name, "001100")
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func test_whenVehiclesListJsonParsedNameNull_thenRemoveObject() {
        guard let data = readJSONData("vehiclesNameNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 1)
            let object = vehicles[0]
            XCTAssertEqual(object.id, 1)
            XCTAssertEqual(object.name, "001100")
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }

    func test_whenVehiclesListJsonParsedPositionNull_thenRemoveObject() {
        guard let data = readJSONData("vehiclesPositionNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 1)
            let object = vehicles[0]
            XCTAssertEqual(object.id, 2)
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func test_whenVehiclesListJsonParsedPriceTimeNull_thenRemoveObject() {
        guard let data = readJSONData("vehiclesPriceTimeNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 1)
            let object = vehicles[0]
            XCTAssertEqual(object.id, 1)
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func test_whenVehiclesListJsonParsedDescriptionNull_thenRemoveObject() {
        guard let data = readJSONData("vehiclesDescriptionNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 1)
            let object = vehicles[0]
            XCTAssertEqual(object.id, 1)
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func test_whenVehiclesListJsonParsedBatterLevelNull_thenRemoveObject() {
        guard let data = readJSONData("vehiclesBatteryLevelNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 1)
            let object = vehicles[0]
            XCTAssertEqual(object.id, 1)
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func test_whenVehiclesListJsonParsedCurrencyNull_thenRemoveObject() {
        guard let data = readJSONData("vehiclesCurrencyNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 1)
            let object = vehicles[0]
            XCTAssertEqual(object.id, 1)
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }
    
    func test_whenVehiclesListJsonParsedPriceNull_thenRemoveObject() {
        guard let data = readJSONData("vehiclesPriceNull") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertEqual(vehicles.count, 1)
            let object = vehicles[0]
            XCTAssertEqual(object.id, 1)
        case .error(let error):
            XCTAssertNotNil(error)
        }
    }
}
