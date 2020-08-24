//
//  CollectionViewController.swift
//  CollectionViewConntrollerDemo
//
//  Created by Tee Shuwn Yuan on 24/08/2020.
//  Copyright © 2020 Tee Shuwn Yuan. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    let dataSource: [String] = ["USA", "Brazil", "China", "United Kingdom", "Japan", "Mexico", "India"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CollectionViewController viewDidLoad")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
