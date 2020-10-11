//
//  TabInfoSection.swift
//  TabDemo
//
//  Created by Cheok Yan Cheng on 11/10/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation

struct TabInfoSection {
    var tabInfos: [TabInfo]
    var footer: String
}

extension TabInfoSection: Hashable {
}
