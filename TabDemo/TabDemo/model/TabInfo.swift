//
//  TabInfo.swift
//  TabDemo
//
//  Created by guest2 on 05/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation
import UIKit

struct TabInfo {
    private static let colorAttrs = [
        ColorAttr.blueTabColor,
        ColorAttr.greenTabColor,
        ColorAttr.redTabColor,
        ColorAttr.orangeTabColor,
        ColorAttr.purpleTabColor,
        ColorAttr.yellowTabColor,
        ColorAttr.cyanTabColor,
        ColorAttr.greyTabColor,
    ];
    
    let type: TabInfoType
    var name: String?
    var colorIndex: Int
    
    func getColor() -> Int {
        return Utils.getThemeManager().getColor(TabInfo.colorAttrs[colorIndex])
    }
    
    func getUIColor() -> UIColor {
        return Utils.getThemeManager().getUIColor(TabInfo.colorAttrs[colorIndex])
    }
}
