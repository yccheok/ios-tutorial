//
//  DarkThemeManager.swift
//  TabDemo
//
//  Created by guest2 on 03/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation
import UIKit

struct DarkThemeManager : ThemeManager {
    static let INSTANCE = DarkThemeManager()
    
    static let colors = [
        ColorAttr.blueTabColor : 0xff5481e6,
        ColorAttr.greenTabColor : 0xff7cb342,
        ColorAttr.redTabColor : 0xffe53935,
        ColorAttr.orangeTabColor : 0xfffb8c00,
        ColorAttr.purpleTabColor : 0xff913ccd,
        ColorAttr.yellowTabColor : 0xfffdd835,
        ColorAttr.cyanTabColor : 0xff2ca8c2,
        ColorAttr.greyTabColor : 0xff757575,
        ColorAttr.normalTabColor : 0xff997950
    ]
    
    static let uiColors: [ColorAttr: UIColor] = {
        var uiColors = [ColorAttr: UIColor]()
        for (colorAttr, color) in colors {
            uiColors[colorAttr] = UIColor(argb: color)
        }
        return uiColors
    }()
    
    private init() {
        print("DarkThemeManager init")
    }
    
    func getColor(_ colorAttr: ColorAttr) -> Int {
        return LightThemeManager.colors[colorAttr]!
    }
    
    func getUIColor(_ colorAttr: ColorAttr) -> UIColor {
        return LightThemeManager.uiColors[colorAttr]!
    }
}
