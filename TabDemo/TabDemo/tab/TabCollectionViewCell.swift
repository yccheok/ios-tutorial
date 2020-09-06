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
    
    private func useText(_ text: String) {
        label.text = text
        label.isHidden = false
        gearImageView.isHidden = true
    }
    
    private func useGearImageView() {
        label.text = nil
        label.isHidden = true
        gearImageView.isHidden = false
    }
    
    func update(_ tabInfo: TabInfo) {
        self.backgroundColor = tabInfo.getUIColor()
        
        // TODO: String localization.
        let type = tabInfo.type
        
        switch type {
        case .All:
            useText("All")
        case .Calendar:
            useText("Calendar")
        case .Custom:
            useText(tabInfo.name!)
        case .Settings:
            useGearImageView()
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
