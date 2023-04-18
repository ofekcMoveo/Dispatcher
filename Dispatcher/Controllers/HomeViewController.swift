//
//  HomeViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 17/04/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchNavBarItem: UIBarButtonItem!
    @IBOutlet weak var notificationsNavBarItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

    }
    
    
    @IBAction func searchPressed(_ sender: UIBarButtonItem) {
        searchNavBarItem.tintColor = .white
        notificationsNavBarItem.tintColor = UIColor(named: "iconsColor")
    }
    
    @IBAction func notificationsPressed(_ sender: UIBarButtonItem) {
        notificationsNavBarItem.tintColor = .white
        searchNavBarItem.tintColor = UIColor(named: "iconsColor")
        
    }
}
