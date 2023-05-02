//
//  AlamofireManager_new.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 01/05/2023.
//

import Foundation
import Alamofire

class AlamofireManager {
    
    func SendRequest<T:Decodable>(_ request: Request, completionHandler: @escaping (Result<T, Error>) -> Void) {
        AF.request(request.baseUrl, method: request.method, parameters: request.parameters, headers: request.headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
}

