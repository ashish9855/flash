//
//  BusinessLayer.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation

protocol BusinessLayerProtocol {
    func vehicleDetails(id: Int, onCompletion: @escaping(_ result: Result<VehicleDetails>) -> Void)
    func vehicles(onCompletion: @escaping(_ result: Result<[Vehicle]>) -> Void)
}

class BusinessLayer: BusinessLayerProtocol {
    
    let requestExecuter = RequestExecutor()
    
    func vehicleDetails(id: Int, onCompletion: @escaping(_ result: Result<VehicleDetails>) -> Void) {
        let resource = VehicleDetails.resource(vehicleId: id)
        guard resource.url != nil else { return }
        requestExecuter.execute(resource) { (parsedResult) in
            switch parsedResult {
            case .success(let parsed):
                guard let value = parsed.value else { return }
                onCompletion(.success(value))
            case .error(let error):
                onCompletion(.error(error))
            }
        }
    }
    
    func vehicles(onCompletion: @escaping(_ result: Result<[Vehicle]>) -> Void) {
        let resource = Vehicle.resource()
        guard resource.url != nil else { return }
        requestExecuter.execute(resource) { (parsedResult) in
            switch parsedResult {
            case .success(let parsed):
                let value = parsed.compactMap({ $0.value })
                onCompletion(.success(value))
            case .error(let error):
                onCompletion(.error(error))
            }
        }
    }
}
