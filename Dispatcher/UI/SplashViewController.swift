//
//  SplashViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 24/04/2023.
//

import UIKit
import FirebaseAuth

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToTabBar, sender: self)
            } else {
                self.performSegue(withIdentifier: SegueIdentifiers.fromSplashToAuth, sender: self)
            }
        }
    }
    

}
