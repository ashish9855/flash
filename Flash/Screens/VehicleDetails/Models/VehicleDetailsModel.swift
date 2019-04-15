//
//  VehicleDetailsModel.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation
import Alamofire

struct VehicleDetails: Codable {

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

extension VehicleDetails {
    
    static func resource(vehicleId: Int) -> Resource<Throwable<VehicleDetails>> {
        return Resource(url: baseUrl,
                        path: "/vehicles/\(vehicleId)",
                        method: HTTPMethod.get)
    }
}
