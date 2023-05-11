//
//  File.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 09/05/2023.
//

import UIKit

class DispatcherAppButton: UIButton {
    
    enum Position: String {
        case start
        case end
    }

    enum ButtonType: String {
        case primary
        case secondary
    }

    var type: ButtonType
    var icon: UIImage?
    var iconPosition: Position
    var title: String
    
    init(frame: CGRect, type: ButtonType, title: String, icon: UIImage? = nil, iconPosition: Position? = nil) {
        self.type = type
        self.title = title
        self.icon = icon
        self.iconPosition = iconPosition ?? Position.start
        
        super.init(frame: frame)
        
        setButtonStyleByType()
        setButtonIcon()
        
        self.layer.cornerRadius = 20
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            if(iconPosition == Position.end) {
                self.semanticContentAttribute = .forceRightToLeft
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
