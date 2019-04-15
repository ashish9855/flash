//
//  VehicleDetailsViewController.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import UIKit

class VehicleDetailsViewController: BaseViewController, RootViewProtocol {

    typealias TypeRootView = VehicleDetailsViewControllerRootView

    struct Input {
        let vehicleId: Int
    }
    
    var input: Input!
    
    static func present(on viewController: UIViewController, input: Input) {
        let vc = instantiate(.vehicleDetails)
        vc.input = input
        vc.present(on: viewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showsNavigationBar = true
        getVehicleDetails()
        showCloseButton()
    }
    
    func getVehicleDetails() {
        rootView.startLoading()
        businessLayer.vehicleDetails(id: input.vehicleId) { [weak self] result in
            self?.rootView.stopLoading()
            switch result {
            case .success(let vehicle):
                self?.rootView.set(with: vehicle)
            case .error(let error):
                print(error.description)
            }
        }
    }
}
