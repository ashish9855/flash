//
//  HTTPStatusCode.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation

public enum HTTPStatusCode: Int {
    case badRequest = 400
    
    func description() -> String {
        switch self {
        case .badRequest:
            return "Bad request"
        }
    }
}
