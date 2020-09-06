//
//  UIColor+Extension.swift
//  TabDemo
//
//  Created by guest2 on 06/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(argb: Int) {
        // &  binary AND operator to zero out other color values
        // >>  bitwise right shift operator
        // Divide by 0xFF because UIColor takes CGFloats between 0.0 and 1.0
        
        let red =   CGFloat((argb & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((argb & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(argb & 0x0000FF) / 0xFF
        let alpha = CGFloat((argb & 0xFF000000) >> 24) / 0xFF
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
