//
//  HeaderViewViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 11/05/2023.
//

import UIKit

protocol HeaderViewDelegate {
    func searchPressed()
    func notificationsPressed()
}

class HeaderView: UIView {
    enum HeaderType: String {
        case mainHeader
        case backHeader
        case approveOrDenyHeader
    }

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    var headerType: HeaderType
    var delegate: HeaderViewDelegate?
        
    init(frame: CGRect, headerType: HeaderType) {
        self.headerType = headerType
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed(NibNames.headerViewNibName, owner: self)
        addSubview(contentView)
        contentView.frame = self.frame
        
        setHeaderItemsByType()
    }
        
    required init?(coder aDecoder: NSCoder) {
        self.headerType = .mainHeader
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed(NibNames.headerViewNibName, owner: self)
        addSubview(contentView)
        contentView.frame = self.frame
        
        setHeaderItemsByType()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "HeaderView", bundle: Bundle(for: type(of: self)))
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.frame = bounds
        addSubview(view)
        setHeaderItemsByType()
    }
    
    
    
    private func setHeaderItemsByType() {
        switch headerType {
        case HeaderType.mainHeader:
            setupMainHeader()
        case HeaderType.backHeader:
            setupBackHeader()
        case HeaderType.approveOrDenyHeader:
            setupApproveOrDenyHeader()
        }
    }
        
    private func setupMainHeader() {
        logoImageView.isHidden = false
        searchButton.isHidden = false
        notificationsButton.isHidden = false
        
        backButton.isHidden = true
    }
    
    private func setupBackHeader() {
        backButton.isHidden = false
        
        logoImageView.isHidden = true
        searchButton.isHidden = true
        notificationsButton.isHidden = true
    }
    
    private func setupApproveOrDenyHeader() {
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        delegate?.searchPressed()
    }
    
    
    @IBAction func notificationsButtenPressed(_ sender: UIButton) {
        delegate?.notificationsPressed()
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
    }
}
