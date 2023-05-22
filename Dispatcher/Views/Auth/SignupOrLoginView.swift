//
//  SignupView.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 15/05/2023.
//

import UIKit

protocol SignupOrLoginDelegate {
    func signupOrLoginPressed(authMode: AuthMode, email: String, password: String)
}

class SignupOrLoginView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var authModeLabel: UILabel!
    @IBOutlet weak var separatorImageView: UIImageView!
    
    var delegate: SignupOrLoginDelegate?
    var mainButton: DispatcherAppButton?
    var secondaryButton: DispatcherAppButton?
    var authMode: AuthMode
    var validatedEmail: String
    var validatedPassword: String
    
    var emailTextField:TextFieldWithValidation?
    var passwordTextField: TextFieldWithValidation?
    var reEnterPasswordTextField: TextFieldWithValidation?

    var emailErrorLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 14))
    var passwordErrorLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 14))
    var reEnterPasswordErrorLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 180, height: 14))

    override init(frame: CGRect) {
        self.authMode = .Signup
        self.validatedEmail = ""
        self.validatedPassword = ""
        super.init(frame: frame)
        Bundle.main.loadNibNamed(NibNames.signupOrLoginViewNibName, owner: self)
        addSubview(contentView)
        contentView.frame = self.frame
        setupUIItems()
    }
        
    required init?(coder aDecoder: NSCoder) {
        self.authMode = .Signup
        self.validatedEmail = ""
        self.validatedPassword = ""
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed(NibNames.signupOrLoginViewNibName, owner: self)
        addSubview(contentView)
        contentView.frame = self.frame
        setupUIItems()
    }
    
    private func setupUIItems() {
        setViewItemsByAuthMode()
        initTextFields()
        setErrorLabels()
                
        setTextFieldsAndLabelsConstarints()
    }

    private func setTextFieldsAndLabelsConstarints(){      
        if let passwordTextField, let emailTextField, let reEnterPasswordTextField {
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            emailErrorLabel.translatesAutoresizingMaskIntoConstraints = false
            passwordTextField.translatesAutoresizingMaskIntoConstraints = false
            passwordErrorLabel.translatesAutoresizingMaskIntoConstraints = false
            reEnterPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
            reEnterPasswordErrorLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                emailTextField.topAnchor.constraint(equalTo: authModeLabel.bottomAnchor, constant: 20),
                emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                emailTextField.heightAnchor.constraint(equalToConstant: 40),
                
                emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3),
                emailErrorLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
                emailErrorLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
                emailErrorLabel.heightAnchor.constraint(equalToConstant: 14)
            ])

            NSLayoutConstraint.activate([
                passwordTextField.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 10),
                passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                passwordTextField.heightAnchor.constraint(equalToConstant: 40),
                
                passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 3),
                passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
                passwordErrorLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
                passwordErrorLabel.heightAnchor.constraint(equalToConstant: 14)
            ])

            NSLayoutConstraint.activate([
                reEnterPasswordTextField.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 10),
                reEnterPasswordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                reEnterPasswordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                reEnterPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
                
                reEnterPasswordErrorLabel.topAnchor.constraint(equalTo: reEnterPasswordTextField.bottomAnchor, constant: 3),
                reEnterPasswordErrorLabel.leadingAnchor.constraint(equalTo: reEnterPasswordTextField.leadingAnchor),
                reEnterPasswordErrorLabel.trailingAnchor.constraint(equalTo: reEnterPasswordTextField.trailingAnchor),
                reEnterPasswordErrorLabel.trailingAnchor.constraint(equalTo: reEnterPasswordTextField.trailingAnchor),
                reEnterPasswordErrorLabel.bottomAnchor.constraint(equalTo: separatorImageView.topAnchor, constant: -20),
                reEnterPasswordErrorLabel.heightAnchor.constraint(equalToConstant: 14)
            ])
        }
    }

    private func setErrorLabels() {
        emailErrorLabel.font = UIFont.systemFont(ofSize: 12)
        passwordErrorLabel.font = UIFont.systemFont(ofSize: 12)
        reEnterPasswordErrorLabel.font = UIFont.systemFont(ofSize: 12)
        
        passwordErrorLabel.numberOfLines = 0
        passwordErrorLabel.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(emailErrorLabel)
        contentView.addSubview(passwordErrorLabel)
        contentView.addSubview(reEnterPasswordErrorLabel)
    }

    private func initTextFields() {
        emailTextField = TextFieldWithValidation(frame: CGRect(x: 0, y: 0, width: contentView.frame.width*0.8, height: 40), type: .email)
        passwordTextField = TextFieldWithValidation(frame: CGRect(x: 0, y: 0, width: contentView.frame.width*0.8, height: 40), type: .password)
        reEnterPasswordTextField = TextFieldWithValidation(frame: CGRect(x: 0, y: 0, width: contentView.frame.width*0.8, height: 40), type: .reEnterPssword)

        contentView.addSubview(emailTextField ?? UITextField())
        contentView.addSubview(passwordTextField ?? UITextField())
        contentView.addSubview(reEnterPasswordTextField ?? UITextField())

        emailTextField?.validationDelegate = self
        passwordTextField?.validationDelegate = self
        reEnterPasswordTextField?.validationDelegate = self

        emailTextField?.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField?.translatesAutoresizingMaskIntoConstraints = false
        reEnterPasswordTextField?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setViewItemsByAuthMode() {
        authModeLabel.text = authMode.rawValue
        switch authMode {
        case .Signup:
            setSignupView()
        case .Login:
            setLoginView()
        }
        
        resetView()
        setAdditionalButtonsSettings()
    }
    
    private func setLoginView() {
        mainButton = DispatcherAppButton(frame: CGRect(x: 0, y: 0, width: contentView.frame.width*0.8, height: 36), type: .primary, title: AuthMode.Login.rawValue.uppercased() , icon: UIImage(named: "Arrow - Right"), iconPosition: .end, cornerRadius: 5)
        secondaryButton = DispatcherAppButton(frame: CGRect(x: 0, y: 0, width: contentView.frame.width*0.8, height: 36), type: .secondary, title: AuthMode.Signup.rawValue.uppercased(), cornerRadius: 5)
        reEnterPasswordTextField?.isHidden = true
        reEnterPasswordErrorLabel.isHidden = true
    }
    
    private func setSignupView() {
        mainButton = DispatcherAppButton(frame: CGRect(x: 0, y: 0, width: contentView.frame.width*0.8, height: 36), type: .primary, title: AuthMode.Signup.rawValue.uppercased() , icon: UIImage(named: "Arrow - Right"), iconPosition: .end, cornerRadius: 5)
        secondaryButton = DispatcherAppButton(frame: CGRect(x: 0, y: 0, width: contentView.frame.width*0.8, height: 36), type: .secondary, title: AuthMode.Login.rawValue.uppercased(), cornerRadius: 5)
        reEnterPasswordTextField?.isHidden = false
        reEnterPasswordErrorLabel.isHidden = false
    }
    
    private func resetView() {
        emailTextField?.styleTextFieldPlaceHolder(placeholderText: TextCostants.emailTextFieldPlaceholder, fontColor: UIColor(named: ColorsPalleteNames.labelsTextColor))
        emailTextField?.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
        emailTextField?.text = nil
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
    
    private func setAdditionalButtonsSettings() {
        mainButton?.addTarget(self, action: #selector(mainButtonPressed), for: .touchUpInside)
        secondaryButton?.addTarget(self, action: #selector(secondaryButtonPressed), for: .touchUpInside)
        
        contentView.addSubview(mainButton ?? UIButton())
        contentView.addSubview(secondaryButton ?? UIButton())
        
        setButtonsConstraints()
    }
    
    private func setButtonsConstraints() {
        if let mainButton, let secondaryButton {
            mainButton.translatesAutoresizingMaskIntoConstraints = false
            secondaryButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                mainButton.topAnchor.constraint(equalTo: separatorImageView.bottomAnchor, constant: 35),
                mainButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                mainButton.heightAnchor.constraint(equalToConstant: 36),
                mainButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),

                secondaryButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                secondaryButton.topAnchor.constraint(equalTo: mainButton.bottomAnchor, constant: 15),
                secondaryButton.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -30),
                secondaryButton.heightAnchor.constraint(equalToConstant: 36),
                secondaryButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),
            ])
       }
    }
    
    private func styleErrorLabel(label: UILabel, error: String) {
        label.text = error
        label.textColor = UIColor(named: ColorsPalleteNames.errorColor)
        label.isHidden = false
    }
    
    @objc private func mainButtonPressed() {
        if (validatedEmail == "" || validatedPassword == "") {
            if (validatedEmail == "") {
                emailTextField?.styleErrorTextField()
                styleErrorLabel(label: emailErrorLabel, error: UserInputErrors.invalidEmailError.errorDescription ?? "")
            } else if (validatedPassword == "") {
                passwordTextField?.styleErrorTextField()
                styleErrorLabel(label: passwordErrorLabel, error: UserInputErrors.invalidPasswordError.errorDescription ?? "")
            }
        } else {
            delegate?.signupOrLoginPressed(authMode: authMode, email: validatedEmail, password: validatedPassword)
        }
    }
    
    @objc private func secondaryButtonPressed() {
        if (authMode == AuthMode.Login) {
            authMode = AuthMode.Signup
        } else {
            authMode = AuthMode.Login
        }
        setViewItemsByAuthMode()
    }
    
    private func handleInput(editedtextField: TextFieldWithValidation?, errorlabel: UILabel, error: UserInputErrors?) {
        if (error != nil) {
            styleErrorLabel(label: errorlabel, error: error?.errorDescription ?? "")
            errorlabel.isHidden = false
            editedtextField?.styleErrorTextField()
        } else {
            editedtextField?.styleValidTextField()
            errorlabel.text = ""
        }
    }
}

extension SignupOrLoginView: TextFieldWithValidationDelegate {
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
