//
//  Utils.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation

func readJSONData(_ fileName: String) -> Data? {
    var data: Data?
    guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return .none }
    do {
        let fileUrl = URL(fileURLWithPath: path)
        data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
    } catch {
    }
    return data
}
