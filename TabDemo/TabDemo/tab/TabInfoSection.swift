//
//  TabInfoSection.swift
//  TabDemo
//
//  Created by Cheok Yan Cheng on 11/10/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import Foundation

struct TabInfoSection {
    // Do not include content items [TabInfo] as member of Section. If not, any mutable operation performed on content items, will
    // misguide Diff framework to throw away entire current Section, and replace it with new Section. This causes flickering effect.
    var footer: String
}

extension TabInfoSection: Hashable {
}
