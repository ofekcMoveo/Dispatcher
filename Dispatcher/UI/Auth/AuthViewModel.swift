//
//  LoginOrRegisterViewModel.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 14/05/2023.
//

import Foundation

enum AuthMode: String {
    case Signup
    case Login
}

class AuthViewModel {
    
    static let shared = AuthViewModel()
    
    let firebaseRepository = FirebaseRepository.shared
    var lastLoginOfCurrentUser: String = ""
    
    private init() {}
    
    func authenticateUser(authMode: AuthMode, email: String, password: String, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        firebaseRepository.exceuteAuthentication(authMode: authMode, email: email, password: password) { errorMsg in
            if let err = errorMsg {
                completionHandler(err)
            } else {
                self.getLastLoginDate()
                completionHandler(nil)
            }
        }
    }
    
    func getLastLoginDate() {
        lastLoginOfCurrentUser = firebaseRepository.getLastLogin()
    }
    
    
}
