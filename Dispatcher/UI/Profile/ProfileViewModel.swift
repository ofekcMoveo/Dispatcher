//
//  ProfileViewModel.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 28/05/2023.
//

import Foundation

class ProfileViewModel {
    let firebaseRepository = FirebaseRepository.shared
    
    func logout(completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        firebaseRepository.logout { errorMsg in
            if let error = errorMsg {
                completionHandler(error)
            } else {
                completionHandler(nil)
            }
        }
        
    }
}
