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
    
    /**
     * Returns the contrast ratio between {@code foreground} and {@code background}.
     * {@code background} must be opaque.
     * <p>
     * Formula defined
     * <a href="http://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef">here</a>.
     */
    /*
    private static func calculateContrast(foreground: UIColor, background: UIColor) -> Double {
        if (background.red != 255) {
            fatalError("background can not be translucent: #"
                    + Integer.toHexString(background));
        }
        if (Color.alpha(foreground) < 255) {
            // If the foreground is translucent, composite the foreground over the background
            foreground = compositeColors(foreground, background);
        }
        final double luminance1 = calculateLuminance(foreground) + 0.05;
        final double luminance2 = calculateLuminance(background) + 0.05;
        // Now return the lighter luminance divided by the darker luminance
        return Math.max(luminance1, luminance2) / Math.min(luminance1, luminance2);
    }*/
}
