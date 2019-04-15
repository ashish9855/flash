//
//  UIStoryboard+Helper.swift
//  Flash
//
//  Created by Ashish Maheshwari on 15.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    class func instantiate(_ storyboard: UIStoryboard.Storyboard) -> Self {
        let storyboard = UIStoryboard(storyboard)
        let viewController = storyboard.instantiateViewController(self)
        return viewController
    }
}

extension UIStoryboard {
    
    enum Storyboard: String {
        case vehicleDetails = "VehicleDetails"
    }
    
    convenience init(_ storyboard: Storyboard) {
        self.init(name: storyboard.rawValue, bundle: nil)
    }
    
    func instantiateViewController<T: UIViewController>(_ :T.Type? = nil) -> T {
        let optionalViewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier)
        
        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}
