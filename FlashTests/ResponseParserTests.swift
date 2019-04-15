//
//  ResponseParserTests.swift
//  FlashTests
//
//  Created by Ashish Maheshwari on 14.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import XCTest
@testable import Flash

class ResponseParserTests: XCTestCase {
    
    func test_whenVehicleDetailsJsonParsed_thenReponseAsExpected() {
        guard let data = readJSONData("vehicleDetails") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: Throwable<VehicleDetails>.self)
        switch parsed {
        case .success(let value):
            XCTAssertNotNil(value)
        default:
            assertionFailure()
        }
    }
    
    func test_whenVehiclesListJsonParsed_thenReponseAsExpected() {
        guard let data = readJSONData("vehicles") else {
            assertionFailure()
            return
        }
        let parsed = ResponseParser.parsedResponse(data, type: [Throwable<Vehicle>].self)
        switch parsed {
        case .success(let value):
            let vehicles = value.compactMap({ $0.value })
            XCTAssertNotNil(vehicles)
        default:
            assertionFailure()
        }
    }
}
