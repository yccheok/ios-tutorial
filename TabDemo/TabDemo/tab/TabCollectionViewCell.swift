//
//  TabCollectionViewCell.swift
//  TabDemo
//
//  Created by guest2 on 05/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class TabCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var gearImageView: UIImageView!
    
    func update(_ tabInfo: TabInfo, _ selected: Bool) {
        // TODO: String localization.
        let type = tabInfo.type
        
        if type == .Settings {
            label.isHidden = true
            gearImageView.isHidden = false
            label.text = nil
            
            if selected {
                self.backgroundColor = tabInfo.getUIColor()
                // TODO: Optimization required. We want to avoid from invoking constructor each time.
                gearImageView.tintColor = UIColor(argb: Utils.getOptimizedPrimaryTextColor(tabInfo.getColor()))
            } else {
                self.backgroundColor = Utils.getUIColor(ColorAttr.normalTabColor)
                gearImageView.tintColor = Utils.getUIColor(ColorAttr.tabIconColor)
            }
        } else {
            label.isHidden = false
            gearImageView.isHidden = true
            
            if selected {
                self.backgroundColor = tabInfo.getUIColor()
                // TODO: Optimization required. We want to avoid from invoking constructor each time.
                label.textColor = UIColor(argb: Utils.getOptimizedPrimaryTextColor(tabInfo.getColor()))
            } else {
                self.backgroundColor = Utils.getUIColor(ColorAttr.normalTabColor)
                label.textColor = Utils.getUIColor(ColorAttr.tabTextColor)
            }
            
            switch type {
            case .All:
                label.text = "All"
            case .Calendar:
                label.text = "Calendar"
            case .Custom:
                label.text = tabInfo.name!
            case .Settings:
                assert(false)
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 12.0, height: 12.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
