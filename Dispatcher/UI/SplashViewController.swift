//
//  SplashViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 24/04/2023.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {
    
    let userDefualtsManager = UserDefaultsManager()
    var isUserFirstLogin: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        checkUserAlreadyLoggedIn()
        
        if (self.isUserFirstLogin == true) {
            self.setFirstLogin()
            self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToOnboarding, sender: self)
        } else {
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if (user != nil) {
                    self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToTabBar, sender: self)
                } else {
                    self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToAuth, sender: self)
                }
            }
        }
    }
    
    func checkUserAlreadyLoggedIn() {
        let userAlreadyLoggedIn = userDefualtsManager.fetchObjectFromUserDefaults(wantedItemKey: UserDefaultsKeys.firstLoginOfUserDefualtsKey) as? Bool
        isUserFirstLogin = !(userAlreadyLoggedIn ?? false)
    }
    
    func setFirstLogin() {
        userDefualtsManager.saveItem(itemToSave: true, itemToSaveKey: UserDefaultsKeys.firstLoginOfUserDefualtsKey)
        isUserFirstLogin = true

    }

}
