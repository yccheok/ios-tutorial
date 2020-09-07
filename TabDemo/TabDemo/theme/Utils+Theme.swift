//
//  Utils+Theme.swift
//  TabDemo
//
//  Created by guest2 on 03/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation
import UIKit

extension Utils {
    static func getThemeManager() -> ThemeManager {
        // TODO:
        return LightThemeManager.INSTANCE
    }
    
    static func getColor(_ colorAttr: ColorAttr) -> Int {
        return getThemeManager().getColor(colorAttr)
    }
    
    static func getUIColor(_ colorAttr: ColorAttr) -> UIColor {
        return getThemeManager().getUIColor(colorAttr)
    }
}
