//
//  Utils+UI.swift
//  TabDemo
//
//  Created by guest2 on 03/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation
import UIKit

extension Utils {
    static func toColor(argb: Int) -> UIColor {
        
        // &  binary AND operator to zero out other color values
        // >>  bitwise right shift operator
        // Divide by 0xFF because UIColor takes CGFloats between 0.0 and 1.0
        
        let red =   CGFloat((argb & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((argb & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(argb & 0x0000FF) / 0xFF
        let alpha = CGFloat((argb & 0xFF000000) >> 24) / 0xFF
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
