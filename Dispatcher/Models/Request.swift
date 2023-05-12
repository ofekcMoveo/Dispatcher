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
    var headers: HTTPHeaders = ["x-api-key": APIConstants.APIkey]
    var parameters: [String: Any]
    var method: HTTPMethod
    
    init(baseUrl: String, parameters: [String : Any], method: HTTPMethod) {
        self.baseUrl = baseUrl
        self.parameters = parameters
        self.method = method
    }
}
