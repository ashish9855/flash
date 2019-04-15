//
//  RootViewProtocol.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation
import UIKit

protocol RootViewProtocol {
    associatedtype TypeRootView
}

extension RootViewProtocol where Self: UIViewController {
    var rootView: TypeRootView {
        return self.view as! TypeRootView
    }
}
