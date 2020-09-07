//
//  Color.swift
//  TabDemo
//
//  Created by guest2 on 06/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

struct Color {
    private init() {
    }
    
    // TODO: Use Apple's system color
    static let primaryTextColorLight = 0xff000000
    static let primaryTextColorDark = 0xffffffff
    
    static let blueTabColorLight = 0xff5481e6
    static let greenTabColorLight = 0xff7cb342
    static let redTabColorLight = 0xffe53935
    static let orangeTabColorLight = 0xfffb8c00
    static let purpleTabColorLight = 0xff913ccd
    static let yellowTabColorLight = 0xfffdd835
    static let cyanTabColorLight = 0xff2ca8c2
    //static let greyTabColorLight = 0xff757575
    static let greyTabColorLight = 0xff424242
    //static let normalTabColorLight = 0xff997950
    static let normalTabColorLight = 0xff757575
    static let tabTextColorLight = 0xb3ffffff
    static let tabIconColorLight = 0xb3ffffff
    
    static func alpha(_ color: Int) -> Int{
        return (color >> 24) & 0xFF
    }
    
    static func red(_ color: Int) -> Int{
        return (color >> 16) & 0xFF
    }
    
    static func green(_ color: Int) -> Int{
        return (color >> 8) & 0xFF
    }
    
    static func blue(_ color: Int) -> Int{
        return color & 0xFF
    }
    
    static func argb(_ alpha: Int, _ red: Int, _ green: Int, _ blue: Int) -> Int {
        return (alpha << 24) | (red << 16) | (green << 8) | blue;
    }
}
