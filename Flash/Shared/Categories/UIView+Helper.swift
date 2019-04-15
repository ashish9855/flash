//
//  UIView+Helper.swift
//  Flash
//
//  Created by Ashish Maheshwari on 15.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
