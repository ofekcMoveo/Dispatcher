//
//  Request.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 01/05/2023.
//

import Foundation
import Alamofire

struct Request {
    var baseUrl: String
    var headers: HTTPHeaders
    var parameters: [String: Any]
    var method: HTTPMethod
    
    init(baseUrl: String, headers: HTTPHeaders, parameters: [String : Any], method: HTTPMethod) {
        self.baseUrl = baseUrl
        self.headers = headers
        self.parameters = parameters
        self.method = method
    }
}
