//
//  ViewController.swift
//  TabDemo
//
//  Created by guest2 on 03/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var tabBottomView: UIView!
    
    var selectedTabIndex: Int = 0
    
    // TODO: String localization.
    private let tabInfos = [
        TabInfo(type: .All, name: nil, colorIndex: 0),
        TabInfo(type: .Calendar, name: nil, colorIndex: 1),
        TabInfo(type: .Custom, name: "Home", colorIndex: 2),
        TabInfo(type: .Custom, name: "Work", colorIndex: 3),
        TabInfo(type: .Settings, name: nil, colorIndex: 0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabCollectionView.collectionViewLayout = layoutConfig()
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        
        updateTabBottomView()
    }

    private func updateTabBottomView() {
        self.tabBottomView.backgroundColor = tabInfos[selectedTabIndex].getUIColor()
    }
    
    private func layoutConfig() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(44), heightDimension: .absolute(44))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 1
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let className = String(describing: TabCollectionViewCell.self)
        
        if let tabCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? TabCollectionViewCell {
            let tabInfo = tabInfos[indexPath.row]
            let selected = indexPath.row == self.selectedTabIndex
            tabCollectionViewCell.update(tabInfo, selected)
            return tabCollectionViewCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedTabIndex = indexPath.row
        
        self.tabCollectionView.reloadData()
        
        updateTabBottomView()
    }
}

