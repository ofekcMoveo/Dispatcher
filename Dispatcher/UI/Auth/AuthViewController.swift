//
//  LoginOrRegisterViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 14/05/2023.
//

import UIKit

class AuthViewController: UIViewController, SignupOrLoginDelegate{

    var authViewModel = AuthViewModel()
    var logoHeader: HeaderView?
    var signupOrLoginView: SignupOrLoginView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        logoHeader = HeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight * 0.45), headerType: .logoHeader)
        self.view.addSubview(logoHeader ?? UIView())
        
        signupOrLoginView = SignupOrLoginView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight * 0.55))
        self.view.addSubview(signupOrLoginView ?? UIView())
        signupOrLoginView?.delegate = self
        
        setViewsConstraints()
    }
        
    private func setViewsConstraints() {
        if let logoHeader {
            logoHeader.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                logoHeader.topAnchor.constraint(equalTo: self.view.topAnchor),
                logoHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                logoHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                logoHeader.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45)
            ])
        }
        if let signupOrLoginView{
            signupOrLoginView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                signupOrLoginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                signupOrLoginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                signupOrLoginView.bottomAnchor.constraint(equalTo:  self.view.bottomAnchor),
                signupOrLoginView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.55)
            ])
        }
    }
    
    func signupOrLoginPressed(authMode: AuthMode, email: String, password: String) {
        authViewModel.authenticateUser(authMode: authMode, email: email, password: password, completionHandler: { errorMsg in
            if(errorMsg != nil) {
                self.present(createErrorAlert(errorMsg!), animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: SegueIdentifiers.fromAuthToTabBar, sender: self)
            }
        })
    }
}

