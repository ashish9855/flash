//
//  VehicleView.swift
//  Flash
//
//  Created by Ashish Maheshwari on 12.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import UIKit

protocol VehicleViewProtocol: class {
    func close()
    func showDetails(for vehicle: Int)
}

class VehicleView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var delegate: VehicleViewProtocol?
    var presentationModel: VehicleViewPresentationModel!
    
    func setup(presentationModel: VehicleViewPresentationModel, delegate: VehicleViewProtocol?) {
        self.presentationModel = presentationModel
        self.delegate = delegate
        handleView()
    }
    
    private func handleView() {
        nameLabel.text = presentationModel.name
        descriptionLabel.text = presentationModel.description
        batteryLabel.text = presentationModel.battery
        priceLabel.text = presentationModel.price
    }
    
    @IBAction func close(_ sender: Any) {
        delegate?.close()
    }
    
    @IBAction func showDetails(_ sender: Any) {
        delegate?.showDetails(for: presentationModel.id)
    }
}
