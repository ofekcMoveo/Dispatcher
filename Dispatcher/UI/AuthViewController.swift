//
//  LoginOrRegisterViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 14/05/2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    var authViewModel = AuthViewModel()
    var logoHeader: HeaderView?
    var authView: SignupOrLoginView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        logoHeader = HeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight * 0.45), headerType: .logoHeader)
        self.view.addSubview(logoHeader ?? UIView())
        
        authView = SignupOrLoginView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight * 0.55), authMode: .Signup)
        self.view.addSubview(authView ?? UIView())
        
        setViewsConstraints()
    }
        
    private func setViewsConstraints() {
        if let logoHeader {
            logoHeader.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                logoHeader.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                logoHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                logoHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                logoHeader.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.45)
            ])
            if let authView{
                authView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    authView.topAnchor.constraint(equalTo: logoHeader.bottomAnchor),
                    authView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    authView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    authView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    authView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.55)
                ])
            }
        }
    }
}
