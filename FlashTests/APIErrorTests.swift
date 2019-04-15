//
//  APIErrorTests.swift
//  FlashTests
//
//  Created by Ashish Maheshwari on 15.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import XCTest
@testable import Flash

class APIErrorTests: XCTestCase {
    
    func testMessage_WhenBadRequest() {
        let error = APIError.HTTPError(statusCode: HTTPStatusCode.badRequest)
        XCTAssertEqual(error.description, "Bad request")
    }
    
    func testMessage_WhenNoInternet() {
        let error = APIError.NoInternet
        XCTAssertEqual(error.description, "There is no internet connection.")
    }
    
    func testMessage_WhenServerError() {
        let error = APIError.ServerError
        XCTAssertEqual(error.description, "Server Error")
    }
    
    func testMessage_WhenJsonParserError() {
        let error = APIError.JsonParserError
        XCTAssertEqual(error.description, "Json Parser Error")
    }
    
    func testMessage_WhenMalformedURL() {
        let error = APIError.MalformedURL
        XCTAssertEqual(error.description, "URl not correct")
    }
    
    func testMessage_WhenUnknown() {
        let error = APIError.Unknown
        XCTAssertEqual(error.description, "Something went wrong. We are working on it.")
    }
}
