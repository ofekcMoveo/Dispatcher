//
//  ProfileViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 17/04/2023.
//

import UIKit

class ProfileViewController: UIViewController {
   
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var profileHeaderView: UIView!
    @IBOutlet weak var optionsTableView: UITableView!
    
    let profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleHeaderShadow()
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
    }
    
    private func styleHeaderShadow() {
        profileHeaderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
           profileHeaderView.layer.shadowOpacity = 0.6
           profileHeaderView.layer.shadowOffset = CGSize(width: 0, height: 2)
           profileHeaderView.layer.shadowRadius = 4
           profileHeaderView.layer.masksToBounds = false
    }
    
    private func handleLogout() {
        self.profileViewModel.logout { errorMsg in
            if let error = errorMsg {
                self.present(createErrorAlert(error), animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: SegueIdentifiers.fromLogoutToAuth, sender: self)
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.selectionStyle = .none
        
        switch indexPath.row {
            case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: TableCellsIdentifiers.profileSettingsCellIdentifier, for: indexPath)
            case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: TableCellsIdentifiers.profileTermsAndPrivacyCellIdentifier, for: indexPath)
            case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: TableCellsIdentifiers.profileLogoutCellIdentifier, for: indexPath)
            default:
                break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
            print("Settings")
            case 1:
            print("terms&privacyCell")
            case 2:
            handleLogout()
            default:
                break
        }
    }
}


