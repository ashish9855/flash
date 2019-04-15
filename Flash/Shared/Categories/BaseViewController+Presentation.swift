//
//  BaseViewController+Presentation.swift
//  Flash
//
//  Created by Ashish Maheshwari on 15.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation
import UIKit

extension BaseViewController {
    
    func present(on viewController: UIViewController, type: PresentationType = .present, animated: Bool = true) {
        switch type {
        case .present:
            navigate(to: viewController, animated: animated)
        }
    }
    
    private func navigate(to viewController: UIViewController, animated: Bool) {
        let navigationController = UINavigationController(rootViewController: self)
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
