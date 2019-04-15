//
//  Resource.swift
//  Flash
//
//  Created by Ashish Maheshwari on 10.04.19.
//  Copyright © 2019 Ashish Maheshwari. All rights reserved.
//

import Foundation
import Alamofire

public typealias QueryParameters = [String: String]

struct Resource<Result> {
    
    let url: URL?
    let method: HTTPMethod
    let headers: HTTPHeaders
    
    init(url: String, path: String = "", method: HTTPMethod = .get, queryParameters: QueryParameters? = nil, headers: HTTPHeaders = [:]) {
        self.url = Resource.makeURL(url, path, queryParameters)
        self.method = method
        self.headers = headers
    }
    
    private static func makeURL(_ url: String, _ path: String, _ queryParameters: QueryParameters? = nil) -> URL? {
        var urlComponents = URLComponents(string: url)
        urlComponents?.path += path
        guard !(queryParameters?.isEmpty ?? true) else { return urlComponents?.url }
        urlComponents?.queryItems = queryParameters?.map({ URLQueryItem(name: $0, value: $1) })
        return urlComponents?.url
    }
    
}
