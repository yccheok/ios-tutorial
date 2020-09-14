//
//  TabInfoSettingsController.swift
//  TabDemo
//
//  Created by guest2 on 08/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class TabInfoSettingsController: UIViewController, TabInfoable {
    private static let tabInfoSettingsItemCellClassName = String(describing: TabInfoSettingsItemCell.self)
    private static let tabInfoSettingsFooterCellClassName = String(describing: TabInfoSettingsFooterCell.self)
    
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
            UINib(nibName: TabInfoSettingsController.tabInfoSettingsItemCellClassName, bundle: nil),
            forCellWithReuseIdentifier: TabInfoSettingsController.tabInfoSettingsItemCellClassName
        )
        
        collectionView.register(
            UINib(nibName: TabInfoSettingsController.tabInfoSettingsFooterCellClassName, bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: TabInfoSettingsController.tabInfoSettingsFooterCellClassName
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
        if let tabInfoSettingsItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabInfoSettingsController.tabInfoSettingsItemCellClassName, for: indexPath) as? TabInfoSettingsItemCell {
            tabInfoSettingsItemCell.delegate = self
            return tabInfoSettingsItemCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TabInfoSettingsController.tabInfoSettingsFooterCellClassName, for: indexPath)
            return footerView

        default:
            fatalError()
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width,
            height: CGFloat(Constants.TAB_INFO_SETTINGS_CELL_HEIGHT)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(
            width: collectionView.frame.size.width,
            height: CGFloat(Constants.TAB_INFO_SETTINGS_CELL_HEIGHT)
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension TabInfoSettingsController: TabInfoSettingsItemCellDelegate {
    func crossButtonClick(_ sender: UIButton) {
        print("crossButtonClick happens")
        
        let hitPoint = (sender as AnyObject).convert(CGPoint.zero, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: hitPoint) {
            // use indexPath to get needed data
            print("crossButtonClick row is -> \(indexPath.row)")
        }
    }
}
