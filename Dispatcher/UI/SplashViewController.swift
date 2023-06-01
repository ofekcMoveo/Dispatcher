//
//  SplashViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 24/04/2023.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {
    
    var isUserAlreadyLoggedIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        isUserAlreadyLoggedIn = checkUserAlreadyLoggedIn()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                if (self.isUserAlreadyLoggedIn == true) {
                    self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToTabBar, sender: self)
                } else {
                    self.setFirstLogin()
                    self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToOnboarding, sender: self)
                }
            } else {
                self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToAuth, sender: self)
            }
        }
    }
    
    
    func checkUserAlreadyLoggedIn() -> Bool {
        do {
            let data = UserDefaultsManager().fetchDataFromUserDefaults(wantedItemKey: UserDefaultsKeys.firstLoginOfUserDefualtsKey)
            let userAlreadyLoggedIn = try JSONDecoder().decode(Bool.self, from: data)
            return !userAlreadyLoggedIn
        } catch (let error) {
            self.present(createErrorAlert(error.localizedDescription), animated: true, completion: nil)
        }
        return false
    }
    
    func setFirstLogin() {
        do {
            let data = try JSONEncoder().encode(true)
            UserDefaultsManager().saveItem(itemToSave: data, itemToSaveKey: UserDefaultsKeys.firstLoginOfUserDefualtsKey)
        } catch (let error) {
            self.present(createErrorAlert(error.localizedDescription), animated: true, completion: nil)
        }
    }

}
