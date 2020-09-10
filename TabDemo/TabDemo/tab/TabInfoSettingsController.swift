//
//  TabInfoSettingsController.swift
//  TabDemo
//
//  Created by guest2 on 08/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class TabInfoSettingsController: UIViewController, TabInfoable {
    private let tabInfoSettingsItemCellClassName = String(describing: TabInfoSettingsItemCell.self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tabInfo: TabInfo?
       
    var viewController: ViewController? {
        if let parent = self.parent?.parent as? ViewController {
            return parent
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(
            UINib(nibName: tabInfoSettingsItemCellClassName, bundle: nil),
            forCellWithReuseIdentifier: tabInfoSettingsItemCellClassName
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TabInfoSettingsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController?.tabInfos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let tabInfoSettingsItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: tabInfoSettingsItemCellClassName, for: indexPath) as? TabInfoSettingsItemCell {
            return tabInfoSettingsItemCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.size.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
