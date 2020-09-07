//
//  Utils+UI.swift
//  TabDemo
//
//  Created by guest2 on 06/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation

extension Utils {
    private static let OPTIMIZED_PRIMARY_TEXT_COLORS = [
        Color.blueTabColorLight : Color.primaryTextColorDark,
        Color.greenTabColorLight : Color.primaryTextColorDark,
        Color.redTabColorLight : Color.primaryTextColorDark,
        Color.orangeTabColorLight : Color.primaryTextColorLight,
        Color.purpleTabColorLight : Color.primaryTextColorDark,
        Color.yellowTabColorLight : Color.primaryTextColorLight,
        Color.cyanTabColorLight : Color.primaryTextColorDark,
        Color.greyTabColorLight : Color.primaryTextColorDark
    ]
    
    private static func toHexString(argb: Int) -> String {
        return NSString(format:"#%08x", argb) as String
    }
    
    public static func getOptimizedPrimaryTextColor(_ backgroundColor: Int) -> Int {
        let _optimizedPrimaryTextColor = OPTIMIZED_PRIMARY_TEXT_COLORS[backgroundColor]
        
        if let optimizedPrimaryTextColor = _optimizedPrimaryTextColor {
            return optimizedPrimaryTextColor
        } else {
            return getContrastForegroundColor(
                Color.primaryTextColorLight,
                Color.primaryTextColorDark,
                backgroundColor
            );
        }
    }
    
    public static func getContrastForegroundColor(_ foregroundColor0: Int, _ foregroundColor1: Int, _ backgroundColor: Int) -> Int{
        if (calculateContrast(foregroundColor0, backgroundColor) > calculateContrast(foregroundColor1, backgroundColor)) {
            return foregroundColor0;
        } else {
            return foregroundColor1;
        }
    }
    
    /**
     * Returns the contrast ratio between {@code foreground} and {@code background}.
     * {@code background} must be opaque.
     * <p>
     * Formula defined
     * <a href="http://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef">here</a>.
     */
    private static func calculateContrast(_ foreground: Int, _ background: Int) -> Double {
        if (Color.alpha(background) != 255) {
            fatalError("background can not be translucent: \(toHexString(argb: background))")
        }
        var _foreground = foreground
        if (Color.alpha(_foreground) < 255) {
            // If the foreground is translucent, composite the foreground over the background
            _foreground = compositeColors(_foreground, background);
        }
        let luminance1 = calculateLuminance(_foreground) + 0.05;
        let luminance2 = calculateLuminance(background) + 0.05;
        // Now return the lighter luminance divided by the darker luminance
        return max(luminance1, luminance2) / min(luminance1, luminance2);
    }
    
    /**
     * Returns the luminance of a color as a float between {@code 0.0} and {@code 1.0}.
     * <p>Defined as the Y component in the XYZ representation of {@code color}.</p>
     */
    public static func calculateLuminance(_ color: Int) -> Double {
        var result = [Double](repeating: 0, count: 3)
        colorToXYZ(color, &result);
        // Luminance is the Y component
        return result[1] / 100;
    }
    
    /**
     * Convert the ARGB color to its CIE XYZ representative components.
     *
     * <p>The resulting XYZ representation will use the D65 illuminant and the CIE
     * 2° Standard Observer (1931).</p>
     *
     * <ul>
     * <li>outXyz[0] is X [0 ...95.047)</li>
     * <li>outXyz[1] is Y [0...100)</li>
     * <li>outXyz[2] is Z [0...108.883)</li>
     * </ul>
     *
     * @param color  the ARGB color to convert. The alpha component is ignored
     * @param outXyz 3-element array which holds the resulting LAB components
     */
    public static func colorToXYZ(_ color: Int, _ outXyz: inout [Double]) {
        RGBToXYZ(Color.red(color), Color.green(color), Color.blue(color), &outXyz);
    }
    
    /**
     * Convert RGB components to its CIE XYZ representative components.
     *
     * <p>The resulting XYZ representation will use the D65 illuminant and the CIE
     * 2° Standard Observer (1931).</p>
     *
     * <ul>
     * <li>outXyz[0] is X [0 ...95.047)</li>
     * <li>outXyz[1] is Y [0...100)</li>
     * <li>outXyz[2] is Z [0...108.883)</li>
     * </ul>
     *
     * @param r      red component value [0..255]
     * @param g      green component value [0..255]
     * @param b      blue component value [0..255]
     * @param outXyz 3-element array which holds the resulting XYZ components
     */
    public static func RGBToXYZ(_ r: Int, _ g: Int, _ b: Int, _ outXyz: inout [Double]) {
        if (outXyz.count != 3) {
            fatalError("outXyz must have a length of 3.");
        }
        var sr = Double(r) / 255.0;
        sr = sr < 0.04045 ? sr / 12.92 : pow((sr + 0.055) / 1.055, 2.4);
        var sg = Double(g) / 255.0;
        sg = sg < 0.04045 ? sg / 12.92 : pow((sg + 0.055) / 1.055, 2.4);
        var sb = Double(b) / 255.0;
        sb = sb < 0.04045 ? sb / 12.92 : pow((sb + 0.055) / 1.055, 2.4);
        outXyz[0] = 100 * (sr * 0.4124 + sg * 0.3576 + sb * 0.1805);
        outXyz[1] = 100 * (sr * 0.2126 + sg * 0.7152 + sb * 0.0722);
        outXyz[2] = 100 * (sr * 0.0193 + sg * 0.1192 + sb * 0.9505);
    }
    
    private static func compositeAlpha(_ foregroundAlpha: Int, _ backgroundAlpha: Int) -> Int {
        return 0xFF - (((0xFF - backgroundAlpha) * (0xFF - foregroundAlpha)) / 0xFF);
    }
    
    private static func compositeComponent(_ fgC: Int, _ fgA: Int, _ bgC: Int, _ bgA: Int, _ a: Int) -> Int {
        if (a == 0) {
            return 0;
        }
        return ((0xFF * fgC * fgA) + (bgC * bgA * (0xFF - fgA))) / (a * 0xFF);
    }
    
    /**
     * Composite two potentially translucent colors over each other and returns the result.
     */
    private static func compositeColors(_ foreground: Int, _ background: Int) -> Int {
        let bgAlpha = Color.alpha(background);
        let fgAlpha = Color.alpha(foreground);
        let a = compositeAlpha(fgAlpha, bgAlpha);
        let r = compositeComponent(Color.red(foreground), fgAlpha,
                Color.red(background), bgAlpha, a);
        let g = compositeComponent(Color.green(foreground), fgAlpha,
                Color.green(background), bgAlpha, a);
        let b = compositeComponent(Color.blue(foreground), fgAlpha,
                Color.blue(background), bgAlpha, a);
        return Color.argb(a, r, g, b);
    }
}
