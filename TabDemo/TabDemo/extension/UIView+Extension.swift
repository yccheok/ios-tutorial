//
//  UIView+Extension.swift
//  TabDemo
//
//  Created by guest2 on 11/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

extension UIView {
    func asCircle() {
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}
