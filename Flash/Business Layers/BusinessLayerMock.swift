//
//  BusinessLayerMock.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation

class BusinessLayerMock: BusinessLayerProtocol {
    
    func vehicleDetails(id: Int, onCompletion: @escaping (Result<VehicleDetails>) -> Void) {
        guard let data = readJSONData("vehicleDetails") else {
            onCompletion(.error(APIError.JsonParserError))
            return
        }
        onCompletion(ResponseParser.parsedResponse(data, type: VehicleDetails.self))
    }
    
    func vehicles(onCompletion: @escaping (Result<[Vehicle]>) -> Void) {
        guard let data = readJSONData("vehicles") else {
            onCompletion(.error(APIError.JsonParserError))
            return
        }
        onCompletion(ResponseParser.parsedResponse(data, type: [Vehicle].self))
    }
    
    func cancelAllRequests() {}
}
