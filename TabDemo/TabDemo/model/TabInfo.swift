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
    
    let id: Int64
    let type: TabInfoType
    var name: String?
    var colorIndex: Int
    
    func getColor() -> Int {
        // TODO: Remove modulus in production.
        return Utils.getThemeManager().getColor(TabInfo.colorAttrs[colorIndex % TabInfo.colorAttrs.count])
    }
    
    func getUIColor() -> UIColor {
        // TODO: Remove modulus in production.
        return Utils.getThemeManager().getUIColor(TabInfo.colorAttrs[colorIndex % TabInfo.colorAttrs.count])
    }
}

extension TabInfo: Equatable {
    static func == (lhs: TabInfo, rhs: TabInfo) -> Bool {
        return
            lhs.type == rhs.type &&
            lhs.name == rhs.name &&
            lhs.colorIndex == rhs.colorIndex
        
    }
}

extension TabInfo {
    func getPageTitle() -> String? {
        switch self.type {    
        case .All:
            return "All"
        case .Calendar:
            return "Calendar"
        case .Custom:
            return self.name
        case .Settings:
            return "Settings"
        }
    }
}
