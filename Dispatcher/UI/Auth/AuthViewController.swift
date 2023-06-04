//
//  LoginOrRegisterViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 14/05/2023.
//

import UIKit

class AuthViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var authView: UIView!
    
    @IBOutlet weak var emailTextField: TextFieldWithValidation!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: TextFieldWithValidation!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var reEnterPasswordTextField: TextFieldWithValidation!
    @IBOutlet weak var reEnterPasswordErrorLabel: UILabel!
    
    @IBOutlet weak var authModeLabel: UILabel!
    @IBOutlet weak var primaryButton: DispatcherAppButton!
    @IBOutlet weak var secondaryButton: DispatcherAppButton!
    
    var authViewModel = AuthViewModel.shared
    var authMode: AuthMode = .Signup
    var validatedEmail: String = ""
    var validatedPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.initView(headerType: .logoHeader)
        emailTextField.initTextField(type: .email)
        passwordTextField.initTextField(type: .password)
        reEnterPasswordTextField.initTextField(type: .reEnterPssword)
        
        emailTextField?.validationDelegate = self
        passwordTextField?.validationDelegate = self
        reEnterPasswordTextField?.validationDelegate = self
        
        setSignupView()
    }
        
        private func setLoginView() {
            primaryButton.initDispatcherButton(type: .primary, title: AuthMode.Login.rawValue.uppercased() , icon: UIImage(named: "Arrow - Right"), iconPosition: .end, cornerRadius: 10)
            
            secondaryButton.initDispatcherButton(type: .secondary, title: AuthMode.Signup.rawValue.uppercased(), cornerRadius: 10)
            
            reEnterPasswordTextField.isHidden = true
            reEnterPasswordErrorLabel.isHidden = true
        }
        
        private func setSignupView() {
            primaryButton.initDispatcherButton(type: .primary, title: AuthMode.Signup.rawValue.uppercased() , icon: UIImage(named: "Arrow - Right"), iconPosition: .end, cornerRadius: 10)
            
            secondaryButton.initDispatcherButton(type: .secondary, title: AuthMode.Login.rawValue.uppercased(), cornerRadius: 10)
            
            reEnterPasswordTextField.isHidden = false
            reEnterPasswordErrorLabel.isHidden = false
        }
        
        func signupOrLoginPressed(authMode: AuthMode, email: String, password: String) {
            authViewModel.authenticateUser(authMode: authMode, email: email, password: password, completionHandler: { errorMsg in
                if let error = errorMsg {
                    self.present(createErrorAlert(error), animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: SegueIdentifiers.fromAuthToTabBar, sender: self)
                }
            })
        }
        
        private func resetAuthView() {
            emailTextField?.styleTextFieldPlaceHolder(placeholderText: TextCostants.emailTextFieldPlaceholder, fontColor: UIColor(named: ColorsPalleteNames.labelsTextColor))
            emailTextField?.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
            emailTextField?.layer.borderWidth = 0
            emailErrorLabel.text = ""
            
            passwordTextField?.styleTextFieldPlaceHolder(placeholderText: TextCostants.passwordTextFieldPlaceholder, fontColor: UIColor(named: ColorsPalleteNames.labelsTextColor))
            passwordTextField?.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
            passwordTextField?.text = nil
            passwordTextField?.layer.borderWidth = 0
            passwordErrorLabel.text = ""
            
            reEnterPasswordTextField?.styleTextFieldPlaceHolder(placeholderText: TextCostants.reEnterPasswordTextFieldPlaceholder, fontColor: UIColor(named: ColorsPalleteNames.labelsTextColor))
            reEnterPasswordTextField?.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
            reEnterPasswordTextField?.text = nil
            reEnterPasswordTextField?.layer.borderWidth = 0
            reEnterPasswordTextField?.text = ""
            reEnterPasswordErrorLabel.text = ""
        }
        
        private func styleErrorLabel(label: UILabel, error: String) {
            label.text = error
            label.textColor = UIColor(named: ColorsPalleteNames.errorColor)
            label.isHidden = false
        }
    
        @IBAction func mainButtonPressed() {
            if (validatedEmail == "" || validatedPassword == "") {
                if (validatedEmail == "") {
                    emailTextField?.styleErrorTextField()
                    styleErrorLabel(label: emailErrorLabel, error: UserInputErrors.invalidEmailError.errorDescription ?? "")
                } else if (validatedPassword == "") {
                    passwordTextField?.styleErrorTextField()
                    styleErrorLabel(label: passwordErrorLabel, error: UserInputErrors.invalidPasswordError.errorDescription ?? "")
                }
            } else {
                authViewModel.authenticateUser(authMode: authMode, email: validatedEmail, password: validatedPassword) { errorMsg in
                    if let err = errorMsg {
                        self.present(createErrorAlert(err), animated: true, completion: nil)
                    } else {
                        self.performSegue(withIdentifier: SegueIdentifiers.fromAuthToTabBar, sender: self)
                    }
                }
            }
        }
        
        @IBAction func secondaryButtonPressed() {
            if (authMode == AuthMode.Login) {
                authMode = AuthMode.Signup
            } else {
                authMode = AuthMode.Login
            }
            setViewItemsByAuthMode()
        }
        
        private func setViewItemsByAuthMode() {
            authModeLabel.text = authMode.rawValue
            switch authMode {
            case .Signup:
                setSignupView()
            case .Login:
                setLoginView()
            }
            
            resetAuthView()
        }
        
        private func handleInput(editedtextField: TextFieldWithValidation?, errorlabel: UILabel, error: UserInputErrors?, missingPasswordRequirements: String? = nil) {
            if (error != nil) {
                styleErrorLabel(label: errorlabel, error: error?.errorDescription ?? "")
                errorlabel.isHidden = false
                editedtextField?.styleErrorTextField()
            } else {
                editedtextField?.styleValidTextField()
                errorlabel.text = ""
            }
        }
        
    func scrollScrollViewDown() {
        let contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + 70)
        scrollView.setContentOffset(contentOffset, animated: true)
    }

    func scrollScrollViewUp() {
        let contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y - 70)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    }

    extension AuthViewController: TextFieldWithValidationDelegate {
    func textFieldBeginEditing() {
        scrollScrollViewDown()
    }

    func textFieldFinishedEditing() {
        scrollScrollViewUp()
    }

    func handleEmailInput(email: String?, error: UserInputErrors?) {
        handleInput(editedtextField: emailTextField, errorlabel: emailErrorLabel, error: error)
        
        if let email {
            validatedEmail = email
        }
    }

    func handlePasswordInput(password: String?, error: UserInputErrors?) {
        handleInput(editedtextField: passwordTextField, errorlabel: passwordErrorLabel, error: error)
        
        if let password {
            if(authMode == AuthMode.Signup) {
                reEnterPasswordTextField?.passwordToCompareTo = "\(password)"
            } else {
                validatedPassword = password
            }
        }
    }

    func handleReEnterPasswordInput(password: String?, error: UserInputErrors?) {
        handleInput(editedtextField: reEnterPasswordTextField, errorlabel: reEnterPasswordErrorLabel, error: error)
        validatedPassword = password ?? ""
    }
    }
    

