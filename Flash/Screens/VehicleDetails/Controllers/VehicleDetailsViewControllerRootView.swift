//
//  VehicleDetailsViewControllerRootView.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import UIKit
import MBProgressHUD

class VehicleDetailsViewControllerRootView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    func startLoading() {
        MBProgressHUD.showAdded(to: self, animated: true)
    }
    
    func stopLoading() {
        MBProgressHUD.hide(for: self, animated: true)
    }
    
    func set(with vehicle: VehicleDetails) {
        nameLabel.text = vehicle.name
        descriptionLabel.text = vehicle.description
        batteryLabel.text = String(vehicle.batteryLevel) + "%"
        priceLabel.text = String(vehicle.price) + String(vehicle.currency)
        durationLabel.text = String(vehicle.priceTime) + "mins"
    }
}
