//
//  TabCollectionViewCell.swift
//  TabDemo
//
//  Created by guest2 on 05/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class TabInfoCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var gearImageView: UIImageView!
    
    private var tabInfo: TabInfo?
    
    override var isSelected: Bool {
        didSet {
            guard let tabInfo = self.tabInfo else {
                return
            }

            // Cell highlight will be performed here. The reason is that, if we rely on self.update solely, we need to
            // perform collectionView.reloadData in collectionView(didSelectItemAt) in order to highlight cell during
            // Tab selection. However, we will fight it very difficult to handling scrolling issue.
            // collectionView.reloadData will always reset
            
            // TODO: Optimization required. We want to avoid from invoking constructor each time.
            if isSelected {
                self.backgroundColor = tabInfo.getUIColor()
                let primaryTextColor = Utils.getOptimizedPrimaryTextColor(tabInfo.getColor())
                gearImageView.tintColor = UIColor(argb: primaryTextColor)
                label.textColor = UIColor(argb: primaryTextColor)
            } else {
                self.backgroundColor = Utils.getUIColor(ColorAttr.normalTabColor)
                gearImageView.tintColor = Utils.getUIColor(ColorAttr.tabIconColor)
                label.textColor = Utils.getUIColor(ColorAttr.tabTextColor)
            }
        }
    }
    
    func update(_ tabInfo: TabInfo, _ selected: Bool) {
        self.tabInfo = tabInfo
        self.isSelected = selected
        
        let type = tabInfo.type
        
        if type == .Settings {
            label.isHidden = true
            gearImageView.isHidden = false
            label.text = nil
        } else {
            label.isHidden = false
            gearImageView.isHidden = true
            
            // TODO: String localization.
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
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 12.0, height: 12.0))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
