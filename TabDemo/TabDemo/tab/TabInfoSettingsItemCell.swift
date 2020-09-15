//
//  TabInfoSettingsItemCell.swift
//  TabDemo
//
//  Created by guest2 on 10/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class TabInfoSettingsItemCell: UICollectionViewCell {

    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    var delegate: TabInfoSettingsItemCellDelegate?
    
    @IBAction func crossButtonClick(_ sender: Any) {
        delegate?.crossButtonClick(sender as! UIButton)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        circleView.asCircle()
    }

}
