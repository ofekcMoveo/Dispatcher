//
//  FirebaseManager.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 17/05/2023.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    func signupUserInFirebase(email: String, password: String, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                completionHandler(err.localizedDescription)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func loginUserInFirebase(email: String, password: String, completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let err = error {
                completionHandler(err.localizedDescription)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func logoutUserFromFirebase(completionHandler: @escaping (_ errorMsg: String?) -> Void) {
        do {
          try Auth.auth().signOut()
            completionHandler(nil)
        } catch let signOutError as NSError {
            completionHandler(signOutError.localizedDescription)
        }
    }
    
    func getLastLoginOfCurrentUser() -> String {
        let previousLogin = UserDefaultsManager().fetchDataFromUserDefaults(wantedItemKey: UserDefaultsKeys.lastLoginOfUserDefualtsKey)
        
        do {
            let data = try JSONEncoder().encode(Auth.auth().currentUser?.metadata.lastSignInDate ?? Date())
            UserDefaultsManager().saveItem(itemToSave: data, itemToSaveKey: UserDefaultsKeys.lastLoginOfUserDefualtsKey)
        } catch (let error) {
            
        }
        
        return formatDate(date: previousLogin.description, format: AppConstants.lastLoginDateFormat)
    }
}
