//
//  VehicleViewViewModel.swift
//  Flash
//
//  Created by Ashish Maheshwari on 12.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation

class VehicleViewPresentationModel {
    
    private let vehicle: Vehicle
    
    var id: Int {
        return vehicle.id
    }
    
    var price: String {
        let price = String(vehicle.price)
        let currency = vehicle.currency
        let time = priceTime
        return price + currency + " for " + time
    }
    
    var name: String {
        return vehicle.name
    }
    
    var description: String {
        return vehicle.description
    }
    
    var battery: String {
        let capacity = String(vehicle.batteryLevel)
        return capacity + "% charged"
    }
    
    private var priceTime: String {
        let time = String(vehicle.priceTime)
        return "\(time) mins"
    }
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
}
