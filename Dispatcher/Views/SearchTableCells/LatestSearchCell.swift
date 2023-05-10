//
//  LatestSearchTableCell.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 02/05/2023.
//

import UIKit

protocol LatestSearchCellDelegate {
    func removeButtonPressed(_ searchToRemove: String)
    func searchCellSelected(_ search: String)
}

class LatestSearchCell: UITableViewCell {
    
    @IBOutlet weak var searchWordsLabel: UILabel!
    @IBOutlet weak var removeSearchCellButton: UIButton!
    
    var delegate: LatestSearchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor(named: ColorsPalleteNames.screenBackgroundColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

    @IBAction func removeSearchCellButtonPressed(_ sender: UIButton) {
        delegate?.removeButtonPressed(searchWordsLabel.text ?? "")
    }
    

    
}
