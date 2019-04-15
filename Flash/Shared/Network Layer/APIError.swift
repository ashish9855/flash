//
//  APIError.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation

enum APIError {
    case NoInternet
    case HTTPError(statusCode: HTTPStatusCode)
    case ServerError
    case JsonParserError
    case MalformedURL
    case Unknown
    
    var description: String {
        switch self {
        case .NoInternet:
            return "There is no internet connection."
        case .HTTPError(let statusCode):
            return statusCode.description()
        case .ServerError:
            return "Server Error"
        case .JsonParserError:
            return "Json Parser Error"
        case .MalformedURL:
            return "URl not correct"
        case .Unknown:
            return "Something went wrong. We are working on it."
        }
    }
}
