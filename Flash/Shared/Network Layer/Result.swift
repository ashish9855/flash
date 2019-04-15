//
//  Result.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation

enum Result<R> {
    case error(APIError)
    case success(R)
}
