//
//  Color.swift
//  TabDemo
//
//  Created by guest2 on 06/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

class Color {
    private init() {
    }
    
    // TODO: Use Apple's system color
    static let primaryTextColorLight = 0xde000000
    static let primaryTextColorDark = 0xffffffff
    
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
