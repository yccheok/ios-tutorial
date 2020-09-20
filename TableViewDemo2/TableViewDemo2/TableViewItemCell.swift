//
//  TableViewItemCell.swift
//  TableViewDemo2
//
//  Created by guest2 on 20/09/2020.
//

import UIKit

class TableViewItemCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
