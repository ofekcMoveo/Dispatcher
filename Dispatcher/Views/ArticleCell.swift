//
//  ArticleCell.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 19/04/2023.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    static let articleCellIdentifier = "articleCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = self.frame.size.height / 6

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
}
