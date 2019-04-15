//
//  ResponseParser.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation
import Alamofire

class ResponseParser {
    
    static func parse<T>(data: DataResponse<Data>, type: T.Type) -> Result <T> where T: Decodable{
        var result: Result<T>
        guard data.error == nil else {
            guard let code = HTTPStatusCode(rawValue: data.response?.statusCode ?? 0) else {
                result = .error(.Unknown)
                return result
            }
            result = .error(.HTTPError(statusCode: code))
            return result
        }
        
        guard let response = data.data else {
            result = .error(APIError.ServerError)
            return result
        }
        
        return ResponseParser.parsedResponse(response, type: T.self)
    }
    
    static func parsedResponse<R>(_ data: Data, type: R.Type) -> Result<R> where R: Decodable {
        do {
            let parsedObject = try JSONDecoder().decode(R.self, from: data)
            return .success(parsedObject)
        } catch {
            return .error(APIError.JsonParserError)
        }
    }
    
}
