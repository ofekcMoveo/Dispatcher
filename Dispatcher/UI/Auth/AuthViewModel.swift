//
//  LoginOrRegisterViewModel.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 14/05/2023.
//

import Foundation
import FirebaseAuth

enum AuthMode: String {
    case Signup
    case Login
}

class AuthViewModel {
    
    func authenticateUser(authMode: AuthMode, email: String, password: String, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        switch authMode{
        case .Login:
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                if let err = error {
                    completionHandler(err.localizedDescription)
                } else {
                    completionHandler(nil)
                }
              
            }
        case .Signup:
            func signupUser(email: String, password: String, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let err = error {
                        completionHandler(err.localizedDescription)
                    } else {
                        completionHandler(nil)
                    }
                }
            }
        }
        
    }
    
    
}
