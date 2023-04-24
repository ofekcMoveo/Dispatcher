//
//  ArticleCell.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 19/04/2023.
//

import UIKit

protocol ArticleCellDelegate {
    func navigateButtonPressed(_ articleTitle: String)
    func favoritesButtonPressed(_ articleTitle: String)
    
}


class ArticleCell: UITableViewCell {
    
    static let articleCellIdentifier = "articleCell"
    

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var dispatchButton: UIButton!
    @IBOutlet weak var moreTagsLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    var delegate: ArticleCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeCardShape()

        tagLabel.layer.cornerRadius = 10
        moreTagsLabel.layer.cornerRadius = 10
        dispatchButton.layer.cornerRadius = 20
        favoritesButton.layer.cornerRadius = favoritesButton.frame.width / 2
    }
    
    func makeCardShape() {
        self.layer.cornerRadius = 20
        contentView.layer.cornerRadius = 20
        contentView.layoutMargins.bottom = 15
        contentView.layoutMargins.top = 15
        contentView.layoutMargins.left = 15
        contentView.layoutMargins.right = 15
        
        layoutSubviews()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.852, green: 0.859, blue: 0.913, alpha: 1).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        contentView.frame = contentView.frame.inset(by: margins)
    }

    
    @IBAction func navigateButtonPressed(_ sender: UIButton) {
        delegate?.navigateButtonPressed(self.titleLabel.text ?? "")
    }
    
    @IBAction func addToFavoritesButtonPressed(_ sender: UIButton) {
        delegate?.favoritesButtonPressed(self.titleLabel.text ?? "")
    }
}
