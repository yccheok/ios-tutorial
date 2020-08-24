//
//  CollectionViewCell.swift
//  CollectionViewConntrollerDemo
//
//  Created by Tee Shuwn Yuan on 24/08/2020.
//  Copyright © 2020 Tee Shuwn Yuan. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    
    func configure(with countryName: String) {
        countryNameLabel.text = countryName
    }
}
