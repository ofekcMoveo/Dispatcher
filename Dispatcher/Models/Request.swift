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
    var urlWithParams: String = ""
    
    init(baseUrl: String, headers: HTTPHeaders, parameters: [String : Any], method: HTTPMethod) {
        self.baseUrl = baseUrl
        self.headers = headers
        self.parameters = parameters
        self.method = method
        
        if(parameters.count > 0) {
            buildUrlWithParams()
        }
    }
    
    mutating func buildUrlWithParams() {
        urlWithParams = ""
        urlWithParams.append("\(baseUrl)?")
        for parm in parameters {
            urlWithParams.append("\(parm.key)=\(parm.value)&")
        }
        
        urlWithParams.removeLast()
    }
    
}
