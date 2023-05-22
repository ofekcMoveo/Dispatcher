//
//  TextFieldExtension.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 15/05/2023.
//

import UIKit

extension UITextField {
    
    func addIconToTextField(position: Position, icon: UIButton) {
        switch position {
        case .start:
            self.leftView = icon
            self.leftViewMode = .always
            self.rightViewMode = .never
        case .end:
            self.rightView = icon
            self.rightViewMode = .always
            self.leftViewMode = .never
        }
    }
    
    func styleTextFieldPlaceHolder(placeholderText: String, fontColor: UIColor?) {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: fontColor ?? .gray])
    }
}
