//
//  FirebaseRepository.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 17/05/2023.
//

import Foundation

class FirebaseRepository {
    let firebaseManager = FirebaseManager()
    
    func exceuteAuthentication(authMode: AuthMode, email: String, password: String, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        switch authMode{
        case .Login:
            firebaseManager.loginUserInFirebase(email: email, password: password) { errorMsg in
                if let error = errorMsg {
                    completionHandler(error)
                } else {
                    completionHandler(nil)
                }
            }
         
        case .Signup:
            firebaseManager.signupUserInFirebase(email: email, password: password) { errorMsg in
                if let error = errorMsg {
                    completionHandler(error)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
}
