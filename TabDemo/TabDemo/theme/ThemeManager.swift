//
//  ThemeManager.swift
//  TabDemo
//
//  Created by guest2 on 03/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation
import UIKit

protocol ThemeManager {
    func getColor(_ colorAttr : ColorAttr) -> UIColor
}

