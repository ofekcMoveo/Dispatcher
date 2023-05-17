//
//  TextFieldExtension.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 15/05/2023.
//

import UIKit

extension UITextField {
//    func addIconToTextField(position: Position, image: UIImage) {
//        let imageView = UIImageView(image: image)
//        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
//        imageView.contentMode = .scaleAspectFit
//
//        switch position {
//        case .start:
//            self.leftView = imageView
//            self.leftViewMode = .always
//            self.rightViewMode = .never
//        case .end:
//            self.rightView = imageView
//            self.rightViewMode = .always
//            self.leftViewMode = .never
//        }
//    }
    
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
