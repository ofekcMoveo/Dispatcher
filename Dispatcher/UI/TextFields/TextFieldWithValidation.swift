//
//  TextFieldWithValidationView.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 15/05/2023.
//

import UIKit

enum TextFieldType {
    case email
    case password
    case reEnterPssword
}

protocol TextFieldWithValidationDelegate {
    func handleEmailInput(email: String?, error: UserInputErrors?)
    func handlePasswordInput(password: String?, error: UserInputErrors?)
    func handleReEnterPasswordInput(password: String?, error: UserInputErrors?)
    func textFieldBeginEditing()
    func textFieldFinishedEditing()
}

class TextFieldWithValidation : UITextField, UITextFieldDelegate {
    var type: TextFieldType
    var passwordToCompareTo: String?
    var hasValidated = false
    var validationDelegate: TextFieldWithValidationDelegate?
    
    init(frame: CGRect, type: TextFieldType) {
        self.type = type
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        self.type = .email
        super.init(coder: coder)
    }
    
    func initTextField(type: TextFieldType) {
        self.type = type
        self.delegate = self
        
        styleTextField()
        setTextFieldByType()
    }
    
    private func styleTextField() {
        self.borderStyle = .roundedRect
        self.layer.borderColor = UIColor(named: ColorsPalleteNames.secondaryButtonColor)?.cgColor
        self.backgroundColor = .white
        self.returnKeyType = .done
    }
    
    private func setTextFieldByType() {
        switch type {
        case .email:
            setEmailTextField()
        case .password:
            setPasswordTextField()
        case .reEnterPssword:
            setReEnterPasswordTextField()
        }
    }
    
    private func setEmailTextField() {
        self.styleTextFieldPlaceHolder(placeholderText: TextCostants.emailTextFieldPlaceholder, fontColor: UIColor(named: ColorsPalleteNames.labelsTextColor))
        self.textContentType = .emailAddress
    }
    
    private func setPasswordTextField() {
        self.styleTextFieldPlaceHolder(placeholderText: TextCostants.passwordTextFieldPlaceholder, fontColor: UIColor(named: ColorsPalleteNames.labelsTextColor))
        self.isSecureTextEntry = true
        setIsSecurePasswordIcon()
    }
    
    private func setReEnterPasswordTextField() {
        self.styleTextFieldPlaceHolder(placeholderText: TextCostants.reEnterPasswordTextFieldPlaceholder, fontColor: UIColor(named: ColorsPalleteNames.labelsTextColor))
        self.isSecureTextEntry = true
        setIsSecurePasswordIcon()
    }

    private func setIsSecurePasswordIcon() {
        let image = (self.isSecureTextEntry ? UIImage(named: "hideText") : UIImage(named: "showText")) ?? UIImage()
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = image
        configuration.imagePadding = 10
        
        let showOrHideTextIcon = UIButton(configuration:configuration)
        showOrHideTextIcon.addTarget(self, action: #selector(showOrHidePasswordPressed) , for: .touchUpInside)
        self.addIconToTextField(position: .end, icon: showOrHideTextIcon)
    }
    
    func styleValidTextField() {
        self.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
        self.layer.borderColor = UIColor(named: ColorsPalleteNames.labelsTextColor)?.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func styleErrorTextField() {
        self.textColor = UIColor(named: ColorsPalleteNames.errorColor)
        self.styleTextFieldPlaceHolder(placeholderText: self.placeholder ?? "", fontColor: UIColor(named: ColorsPalleteNames.errorColor))
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 0.5
    }
    
    @objc private func showOrHidePasswordPressed() {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setIsSecurePasswordIcon()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        
        if(type == .reEnterPssword) {
            validationDelegate?.textFieldBeginEditing()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(hasValidated == true) {
            guard let passwordTextField = textField as? TextFieldWithValidation else {
                return true
            }
            var updatedPassword = passwordTextField.text ?? ""
            updatedPassword.replaceSubrange(Range(range, in: updatedPassword)!, with: string)
            
            if(self.type == .password) {
                validatePassword(userInput: updatedPassword)
            } else if (self.type == .email) {
                validateEmail(userInput: updatedPassword)
            }
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.layer.shadowOpacity = 0
        self.resignFirstResponder()
        switch type {
        case .email:
            validateEmail(userInput: textField.text)
        case .password:
            validatePassword(userInput: textField.text)
        case .reEnterPssword:
            validationDelegate?.textFieldFinishedEditing()
            comparePassword(userInput: textField.text)            
        }
        return true
    }
    
    //MARK: Input validation funcs

    private func validateEmail(userInput: String?) {
        var errorString = ""
        hasValidated = true
        if let emailAddress = userInput {
            if (emailAddress.contains("@")) {
                let components = emailAddress.components(separatedBy: "@")
                let username = components[0]
                let domain = components[1]
                if (username.isEmpty) {
                    validationDelegate!.handleEmailInput(email: nil, error: UserInputErrors.missingUsernameInEmailError)
                } else if (domain.isEmpty) {
                    validationDelegate!.handleEmailInput(email: nil, error: UserInputErrors.missingDomainInEmailError)
                } else {
                    validationDelegate!.handleEmailInput(email: emailAddress, error: nil)
                }
            } else {
                validationDelegate!.handleEmailInput(email: nil, error: UserInputErrors.missingSignInEmailError)
            }
        } else {
            validationDelegate!.handleEmailInput(email: nil, error: UserInputErrors.invalidEmailError)
        }
    }
       
   private func validatePassword(userInput: String?) {
       hasValidated = true
       let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$"
       validationByRegex(regexExpression: passwordRegex, inputToEvaluate: userInput, handleValidationResult: validationDelegate!.handlePasswordInput)
   }
   
   private func comparePassword(userInput: String?) {
       hasValidated = true
       if (userInput != passwordToCompareTo && userInput != "") {
           validationDelegate?.handleReEnterPasswordInput(password: nil, error: UserInputErrors.passwordsNotMatchError)
       } else {
           validationDelegate?.handleReEnterPasswordInput(password: passwordToCompareTo, error: nil)
       }
   }
   
   private func validationByRegex(regexExpression: String, inputToEvaluate: String?, handleValidationResult: @escaping (_ input: String?, _ errorMsg: UserInputErrors?) -> Void) {
       if(inputToEvaluate != "") {
           let predicate = NSPredicate(format: "SELF MATCHES %@", regexExpression)
           if(predicate.evaluate(with: inputToEvaluate)) {
               handleValidationResult(inputToEvaluate, nil)
           } else {
               if(self.type == .email) {
                   handleValidationResult(nil, UserInputErrors.invalidEmailError)
               } else if (self.type == .password){
                   handleValidationResult(nil, UserInputErrors.invalidPasswordError)
               }
               
           }
       }
       
   }
}

