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
        
        let showOrHideTextIcon = UIButton(frame: CGRect(x: 0, y: 0, width: (image.size.width + 16), height: (image.size.height + 10)))
        showOrHideTextIcon.setImage(image, for: .normal)
        showOrHideTextIcon.imageView?.contentMode = .scaleAspectFit
        showOrHideTextIcon.addTarget(self, action: #selector(showOrHidePasswordPressed) , for: .touchUpInside)
        
        showOrHideTextIcon.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
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
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldShouldReturn(textField)
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
            comparePassword(userInput: textField.text)
        }
        return true
    }
    
    //MARK: Input validation funcs

    private func validateEmail(userInput: String?) {
          let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+"
           validationByRegex(regexExpression: emailRegex, inputToEvaluate: userInput, handleValidationResult: validationDelegate!.handleEmailInput)
       }
       
   private func validatePassword(userInput: String?) {
       let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$"
       validationByRegex(regexExpression: passwordRegex, inputToEvaluate: userInput, handleValidationResult: validationDelegate!.handlePasswordInput)
   }
   
   private func comparePassword(userInput: String?) {
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

