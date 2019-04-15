//
//  ResourceTests.swift
//  FlashTests
//
//  Created by Ashish Maheshwari on 15.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import XCTest
@testable import Flash

class ResourceTests: XCTestCase {
    
    let url = "https://www.dummy.com"
    
    func testUrl_WhenURLAndMethodGiven() {
        let resource = Resource<Any>(url: url)
        XCTAssertEqual(resource.url?.absoluteString, "https://www.dummy.com")
    }
    
    func testUrl_WhenPathAlsoGiven_ThenAppendPath() {
        let resource = Resource<Any>(url: url, path: "/vehicles")
        XCTAssertEqual(resource.url?.absoluteString, "https://www.dummy.com/vehicles")
    }
    
    func testUrl_WhenQueryParametersAndPathGiven_ThenAppendPathAndParametersToUrl() {
        let resource = Resource<Any>(url: url, path: "/vehicles", queryParameters: ["id" : "1"])
        XCTAssertEqual(resource.url?.absoluteString, "https://www.dummy.com/vehicles?id=1")
    }
    
    func testUrl_WhenOnlyQueryParametersGiven_ThenAppendParametersToUrl() {
        let resource = Resource<Any>(url: url, queryParameters: ["id" : "1"])
        XCTAssertEqual(resource.url?.absoluteString, "https://www.dummy.com?id=1")
    }
}
