//
//  ReorderDelegate.swift
//  TabDemo
//
//  Created by guest2 on 21/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation
import UIKit

protocol ReorderDelegate {
    func began(_ gesture: UILongPressGestureRecognizer)
    func changed(_ gesture: UILongPressGestureRecognizer)
    func end(_ gesture: UILongPressGestureRecognizer)
    func cancel(_ gesture: UILongPressGestureRecognizer)
}
