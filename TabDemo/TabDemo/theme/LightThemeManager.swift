//
//  LightThemeManager.swift
//  TabDemo
//
//  Created by guest2 on 03/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation
import UIKit

class LightThemeManager : ThemeManager {
    static let INSTANCE = LightThemeManager()
    
    static let colors = [
        ColorAttr.blueTabColor : Utils.toColor(argb: 0xff5481e6),
        ColorAttr.greenTabColor : Utils.toColor(argb: 0xff7cb342),
        ColorAttr.redTabColor : Utils.toColor(argb: 0xffe53935),
        ColorAttr.orangeTabColor : Utils.toColor(argb: 0xfffb8c00),
        ColorAttr.purpleTabColor : Utils.toColor(argb: 0xff913ccd),
        ColorAttr.yellowTabColor : Utils.toColor(argb: 0xfffdd835),
        ColorAttr.cyanTabColor : Utils.toColor(argb: 0xff2ca8c2),
        ColorAttr.greyTabColor : Utils.toColor(argb: 0xff757575),
        ColorAttr.normalTabColor : Utils.toColor(argb: 0xff997950)
    ]
    
    private init() {
        print("LightThemeManager init")
    }
    
    func getColor(_ colorAttr: ColorAttr) -> UIColor {
        return LightThemeManager.colors[colorAttr]!
    }
}
