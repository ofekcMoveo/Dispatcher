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
}

class TextFieldWithValidation : UITextField, UITextFieldDelegate {
    var type: TextFieldType
    var passwordToCompareTo: String?
    var validationDelegate: TextFieldWithValidationDelegate?
        
    init(frame: CGRect, type: TextFieldType) {
        self.type = type
        super.init(frame: frame)
        self.delegate = self
        styleTextField()
        setTextFieldByType()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        let showOrHideTextIcon = UIButton()
        showOrHideTextIcon.setImage(image, for: .normal)
        showOrHideTextIcon.imageView?.contentMode = .scaleAspectFit
        showOrHideTextIcon.addTarget(self, action: #selector(showOrHidePasswordPressed) , for: .touchUpInside)
        self.addIconToTextField(position: .end, icon: showOrHideTextIcon)
    }
    
    func styleValidTextField() {
        self.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
        self.layer.borderColor = UIColor(named: ColorsPalleteNames.labelsTextColor)?.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func styleErrorTextField() {
        self.textColor = .red
        self.styleTextFieldPlaceHolder(placeholderText: self.placeholder ?? "", fontColor: .red)
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 0.5
    }
    
    @objc private func showOrHidePasswordPressed() {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setIsSecurePasswordIcon()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        switch type {
        case .email:
            validateEmail(userInput: self.text)
        case .password:
            validatePassword(userInput: self.text)
        case .reEnterPssword:
            comparePassword(userInput: self.text)
        }
           return true
    }
    
    //MARK: Input validation funcs

    private func validateEmail(userInput: String?) {
       let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+"
       let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        if(emailPredicate.evaluate(with: userInput)){
            validationDelegate?.handleEmailInput(email: userInput, error: nil)
        } else {
            validationDelegate?.handleEmailInput(email: nil, error: UserInputErrors.invalidEmailError)
        }
    }
    
    private func validatePassword(userInput: String?) {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        if(passwordPredicate.evaluate(with: userInput)) {
            validationDelegate?.handlePasswordInput(password: userInput, error: nil)
        } else {
            validationDelegate?.handlePasswordInput(password: nil, error: UserInputErrors.invalidPasswordError)
        }
    }
    
    private func comparePassword(userInput: String?) {
        if (userInput != passwordToCompareTo) {
            validationDelegate?.handleReEnterPasswordInput(password: nil, error: UserInputErrors.passwordsNotMatchError)
        } else {
            validationDelegate?.handleReEnterPasswordInput(password: passwordToCompareTo, error: nil)
        }
    }
}

