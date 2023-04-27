//
//  SplashViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 24/04/2023.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.performSegue(withIdentifier: "fromSplashToTabBar", sender: self)
        }
    }
    

}
