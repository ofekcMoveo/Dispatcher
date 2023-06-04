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
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let currentUser = user {
                self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToTabBar, sender: self)
            } else {
                    if (self.isUserFirstLogin == true) {
                        self.setFirstLogin()
                        self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToOnboarding, sender: self)
                    } else {
                        self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToAuth, sender: self)
                    }
                }
            }
    }
    
    func checkUserAlreadyLoggedIn() {
        do {
            let data = userDefualtsManager.fetchDataFromUserDefaults(wantedItemKey: UserDefaultsKeys.firstLoginOfUserDefualtsKey)
            let userAlreadyLoggedIn = try JSONDecoder().decode(Bool.self, from: data)
            isUserFirstLogin = !userAlreadyLoggedIn
        } catch (let error) {
            self.present(createErrorAlert(error.localizedDescription), animated: true, completion: nil)
        }
    }
    
    func setFirstLogin() {
        do {
            let data = try JSONEncoder().encode(true)
            userDefualtsManager.saveItem(itemToSave: data, itemToSaveKey: UserDefaultsKeys.firstLoginOfUserDefualtsKey)
            isUserFirstLogin = true
        } catch (let error) {
            self.present(createErrorAlert(error.localizedDescription), animated: true, completion: nil)
        }
    }

}
