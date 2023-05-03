//
//  LatestSearchTableCell.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 02/05/2023.
//

import UIKit

protocol PreviousSearchCellDelegate {
    func removeButtonPressed(_ searchToRemove: String)
}

class PreviousSearchCell: UITableViewCell {
    
    @IBOutlet weak var searchWordsLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    var delegate: PreviousSearchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchWordsLabel.text == "" ? (removeButton.isHidden = true) : (removeButton.isHidden = false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        delegate?.removeButtonPressed(searchWordsLabel.text ?? "")
    }
    
}
