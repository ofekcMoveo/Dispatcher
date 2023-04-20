//
//  ArticleCell.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 19/04/2023.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    static let articleCellIdentifier = "articleCell"
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var dispatchButton: UIButton!
    @IBOutlet weak var moreTagsLabel: UILabel!
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = self.frame.size.height / 10
    
        tagLabel.layer.cornerRadius = 10
        moreTagsLabel.layer.cornerRadius = 10
        dispatchButton.layer.cornerRadius = 20
        addToFavoritesButton.layer.cornerRadius = addToFavoritesButton.frame.width / 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    
    
}
