//
//  ArticlesTableHeaderView.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 31/05/2023.
//

import UIKit

class ArticlesTableHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var lastLoginLabel: UILabel!
    @IBOutlet weak var lastLoginDateLabel: UILabel!
    
    func initView(lastLoginDate: String) {
        commonInit()
        headline.text = TextCostants.topHeadlinesHeaderText
        if (lastLoginDate != "") {
            lastLoginDateLabel.text = lastLoginDate
        } else {
            lastLoginLabel.isHidden = true
            lastLoginDateLabel.isHidden = true
        }
    }
        
    private func commonInit() {
        Bundle.main.loadNibNamed(NibNames.articlesTableHeaderView, owner: self, options: nil)
        contentView.frame = self.bounds
        self.addSubview(contentView)
    }
     
    
    
}
