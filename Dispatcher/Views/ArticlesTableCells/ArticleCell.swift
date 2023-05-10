//
//  ArticleCell.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 19/04/2023.
//

import UIKit

//MARK: - ArticleCellDelegate

protocol ArticleCellDelegate {
    func navigateButtonPressed(_ articleID: String)
    func favoritesButtonPressed(_ articleID: String)
    
}

//MARK: - ArticleCell class

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var moreTagsLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var articleImage: UIImageView!
    
    var dispatchButton = DispatcherAppButton()
    var delegate: ArticleCellDelegate?
    var id: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCellMarginsAndBorder()
        setTextColorForCellElements()
        setCornerRadiusForCellElements()
        favoritesButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        setupDispatchButton()
    }
    
    private func setupDispatchButton() {
        dispatchButton.frame(forAlignmentRect: CGRect(x: 11, y: 397, width: 310, height: 36))
        dispatchButton.setupPrimaryButtonWithArrow(title: AppConstants.navigateToDispatchText)
        dispatchButton.addTarget(self, action: #selector(self.navigateToDisptachPressed), for: .touchUpInside)
        self.contentView.addSubview(dispatchButton)
        
        setDispatchButtonConstraints()
    }
    
    private func setDispatchButtonConstraints() {
        dispatchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dispatchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            dispatchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -11),
            dispatchButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 10),
            dispatchButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func setCornerRadiusForCellElements() {
        tagLabel.layer.cornerRadius = 10
        moreTagsLabel.layer.cornerRadius = 10
        favoritesButton.layer.cornerRadius = favoritesButton.frame.width / 2
    }
    
    private func setTextColorForCellElements() {
        tagLabel.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
        moreTagsLabel.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
        titleLabel.textColor = .black
        subTitleLabel.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
        dateLabel.textColor = UIColor(named: ColorsPalleteNames.labelsTextColor)
    }
    
    private func setCellMarginsAndBorder() {
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
    
    @IBAction func favoritesButtonPressed(_ sender: UIButton) {
        delegate?.favoritesButtonPressed(id)
    }
    
    @objc func navigateToDisptachPressed() {
        delegate?.navigateButtonPressed(id)
    }
}
