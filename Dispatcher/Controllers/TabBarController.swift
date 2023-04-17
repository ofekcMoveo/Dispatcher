import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet weak var notificationsBarButton: UIBarButtonItem!
    @IBOutlet weak var searchBarButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func notificationsPressed(_ sender: UIBarButtonItem) {
        notificationsBarButton.tintColor = .white
        searchBarButton.tintColor = UIColor(named: "iconsColor")
    }
    
    @IBAction func searchPressed(_ sender: UIBarButtonItem) {
        sender.tintColor = .white
        notificationsBarButton.tintColor = UIColor(named: "iconsColor")
    }
    
    
    
}
