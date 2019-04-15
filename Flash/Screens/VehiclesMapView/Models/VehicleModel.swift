//
//  Vehicle.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

struct Vehicle: Codable {
    let id: Int
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    let batteryLevel: Int
    let timestamp: String
    let price: Int
    let priceTime: Int
    let currency: String
}

private var baseUrl: String {
    return Config.Backend.baseUrl
}

extension Vehicle {
    static func resource() -> Resource<[Throwable<Vehicle>]> {
        return Resource(url: baseUrl,
                        path: "/vehicles",
                        method: HTTPMethod.get)
    }
}

extension Vehicle: Equatable {
    static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.id == rhs.id && lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
