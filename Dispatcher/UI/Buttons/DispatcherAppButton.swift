//
//  File.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 09/05/2023.
//

import UIKit

class DispatcherAppButton: UIButton {
    enum ButtonType: String {
        case primary
        case secondary
    }

    var type: ButtonType
    var icon: UIImage?
    var iconPosition: Position?
    var title: String
    
    init(frame: CGRect, type: ButtonType, title: String, icon: UIImage? = nil, iconPosition: Position? = nil, cornerRadius: CGFloat = 20) {
        self.type = type
        self.title = title
        self.icon = icon
        self.iconPosition = iconPosition ?? Position.start
        
        super.init(frame: frame)
        self.layer.cornerRadius = cornerRadius
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        setButtonStyleByType()
        setButtonIcon()
    }

    required init?(coder: NSCoder) {
        self.type = .primary
        self.title = ""
        super.init(coder: coder)
        
        self.layer.cornerRadius = 20
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        setButtonStyleByType()
        setButtonIcon()
    }
    
    func initDispatcherButton(type: ButtonType, title: String, icon: UIImage? = nil, iconPosition: Position? = nil, cornerRadius: CGFloat = 20) {
        self.type = type
        self.title = title
        self.icon = icon
        self.iconPosition = iconPosition ?? Position.start
                
        self.layer.cornerRadius = cornerRadius
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        setButtonStyleByType()
        setButtonIcon()
    }
    
    private func setButtonStyleByType() {
        switch type {
        case ButtonType.primary:
            setupPrimaryButton()
        case ButtonType.secondary:
            setupSecondaryButton()
        }
    }
    
    private func setButtonIcon() {
        if(icon != nil) {
            self.setImage(icon, for: .normal)
            self.imageView?.tintColor = .white
            self.adjustsImageWhenHighlighted = false
            if(iconPosition == Position.end) {
                self.semanticContentAttribute = .forceRightToLeft
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            }
        }
    }

    func setupPrimaryButton() {
        self.backgroundColor = UIColor(named: ColorsPalleteNames.primaryButtonColor)
        self.setTitleColor(.white, for: .normal)
    }

    func setupSecondaryButton() {
        self.backgroundColor = UIColor(named: ColorsPalleteNames.secondaryButtonColor)
        self.setTitleColor(UIColor(named: ColorsPalleteNames.labelsTextColor), for: .normal)
    }

}
