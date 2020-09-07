//
//  LightThemeManager.swift
//  TabDemo
//
//  Created by guest2 on 03/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation
import UIKit

struct LightThemeManager : ThemeManager {
    static let INSTANCE = LightThemeManager()
    
    static let colors = [
        ColorAttr.blueTabColor : Color.blueTabColorLight,
        ColorAttr.greenTabColor : Color.greenTabColorLight,
        ColorAttr.redTabColor : Color.redTabColorLight,
        ColorAttr.orangeTabColor : Color.orangeTabColorLight,
        ColorAttr.purpleTabColor : Color.purpleTabColorLight,
        ColorAttr.yellowTabColor : Color.yellowTabColorLight,
        ColorAttr.cyanTabColor : Color.cyanTabColorLight,
        ColorAttr.greyTabColor : Color.greyTabColorLight,
        ColorAttr.normalTabColor : Color.normalTabColorLight,
        ColorAttr.tabTextColor : Color.tabTextColorLight,
        ColorAttr.tabIconColor : Color.tabIconColorLight
    ]
    
    static let uiColors: [ColorAttr: UIColor] = {
        var uiColors = [ColorAttr: UIColor]()
        for (colorAttr, color) in colors {
            uiColors[colorAttr] = UIColor(argb: color)
        }
        return uiColors
    }()
    
    private init() {
        print("LightThemeManager init")
    }
    
    func getColor(_ colorAttr: ColorAttr) -> Int {
        return LightThemeManager.colors[colorAttr]!
    }
    
    func getUIColor(_ colorAttr: ColorAttr) -> UIColor {
        return LightThemeManager.uiColors[colorAttr]!
    }
}
