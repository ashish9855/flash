//
//  Throwable.swift
//  Flash
//
//  Created by Ashish Maheshwari on 15.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation

enum Throwable<T: Decodable>: Decodable {
    case success(T)
    case failure(Error)
    
    init(from decoder: Decoder) throws {
        do {
            let decoded = try T(from: decoder)
            self = .success(decoded)
        } catch let error {
            self = .failure(error)
        }
    }
}

extension Throwable {
    var value: T? {
        switch self {
        case .failure(_):
            return nil
        case .success(let value):
            return value
        }
    }
}
