//
//  NavigationViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 18/04/2023.
//

import UIKit

class NavigationViewController: UINavigationController {

    @IBOutlet weak var notificationsBarButton: UIBarButtonItem!
    @IBOutlet weak var searchBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func notificationsPressed(_ sender: UIBarButtonItem) {
        notificationsBarButton.tintColor = .white
        searchBarButton.tintColor = UIColor(named: "iconsColor")
    }
    
    @IBAction func searchPressed(_ sender: UIBarButtonItem) {
        sender.tintColor = .white
        notificationsBarButton.tintColor = UIColor(named: "iconsColor")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
