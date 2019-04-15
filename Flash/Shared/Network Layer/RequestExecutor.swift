//
//  RequestExecutor.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation
import Alamofire

class RequestExecutor {
    
    func cancelAllRequests() {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach{ $0.cancel() }
        }
    }
    
    func execute<R>(_ resource: Resource<R>, result: @escaping ((Result<R>) -> Void)) where R: Decodable {
        guard let url = resource.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        request.allHTTPHeaderFields = resource.headers
        Alamofire.request(request).responseData { [weak self] data in
            guard let `self` = self else { return }
            result(self.parser(type: R.self, data))
        }
    }
    
    private func parser<T>(type: T.Type, _ response: DataResponse<Data>) -> Result<T> where T: Decodable {
        return ResponseParser.parse(data: response, type: type)
    }
}
