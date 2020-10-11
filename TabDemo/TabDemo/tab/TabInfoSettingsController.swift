//
//  TabInfoSettingsController.swift
//  TabDemo
//
//  Created by guest2 on 08/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

func shadow(_ view: UIView) {
    view.layer.cornerRadius = 0
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0);
    
    //view.layer.shadowOpacity = 0.3
    view.layer.shadowOpacity = 0.8  // Stronger value for demo purpose.
    
    view.layer.shadowRadius = 4.0
    view.layer.masksToBounds = false
}

func unShadow(_ view: UIView) {
    view.layer.masksToBounds = true
}

func enlargeTransparent(_ view: UIView) {
    view.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
    view.alpha = 0.7
}

func unEnlargeTransparent(_ view: UIView) {
    view.transform = CGAffineTransform.identity
    view.alpha = 1.0
}

class ReorderCompositionalLayout : UICollectionViewCompositionalLayout {
    override func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {
        let attributes = super.layoutAttributesForInteractivelyMovingItem(at: indexPath as IndexPath, withTargetPosition: position)
        
        attributes.alpha = 0.7
        attributes.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)

        return attributes
    }
}

class TabInfoSettingsController: UIViewController, TabInfoable {
    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<TabInfoSection, TabInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<TabInfoSection, TabInfo>
    
    private static let tabInfoSettingsItemCellClassName = String(describing: TabInfoSettingsItemCell.self)
    private static let tabInfoSettingsFooterCellClassName = String(describing: TabInfoSettingsFooterCell.self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tabInfo: TabInfo?
       
    var movingIndexPath: IndexPath?
    
    var viewController: ViewController? {
        if let parent = self.parent?.parent as? ViewController {
            return parent
        }
        return nil
    }
    
    var filteredTabInfos: [TabInfo]? {
        return self.viewController?.tabInfos.filter({ $0.type != TabInfoType.Settings })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = layoutConfig()
        
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
    
    private func layoutConfig() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .vertical
        
        return ReorderCompositionalLayout (sectionProvider: { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(CGFloat(Constants.TAB_INFO_SETTINGS_CELL_HEIGHT))
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(CGFloat(Constants.TAB_INFO_SETTINGS_CELL_HEIGHT))
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            
            let footerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(CGFloat(Constants.TAB_INFO_SETTINGS_CELL_HEIGHT))
            )
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: footerSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            section.boundarySupplementaryItems = [sectionFooter]
            
            return section
        }, configuration: configuration)
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

extension TabInfoSettingsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredTabInfos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let tabInfoSettingsItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: TabInfoSettingsController.tabInfoSettingsItemCellClassName, for: indexPath) as? TabInfoSettingsItemCell {
            tabInfoSettingsItemCell.delegate = self
            tabInfoSettingsItemCell.reorderDelegate = self
            tabInfoSettingsItemCell.textField.text = filteredTabInfos?[indexPath.row].getPageTitle()
            
            if indexPath.item == movingIndexPath?.item {
                shadow(tabInfoSettingsItemCell)

                enlargeTransparent(tabInfoSettingsItemCell)
            } else {
                unShadow(tabInfoSettingsItemCell)
                
                unEnlargeTransparent(tabInfoSettingsItemCell)
            }
            
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
}

extension TabInfoSettingsController: TabInfoSettingsItemCellDelegate {
    func crossButtonClick(_ sender: UIButton) {
        let hitPoint = (sender as AnyObject).convert(CGPoint.zero, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: hitPoint) {
            // use indexPath to get needed data

            viewController?.deleteTabInfo(indexPath)
            
            self.collectionView.deleteItems(at: [indexPath])
        }
    }
}

extension TabInfoSettingsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewController?.moveTabInfo(at: sourceIndexPath, to: destinationIndexPath)
        
        // FIXME: Use diff data source.
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension TabInfoSettingsController: ReorderDelegate {
    func began(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: self.collectionView)
        
        guard let indexPath = self.collectionView?.indexPathForItem(at: location) else {
            return
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath as IndexPath) as? TabInfoSettingsItemCell else {
            return
        }
        
        self.movingIndexPath = indexPath
        
        collectionView?.beginInteractiveMovementForItem(at: indexPath)

        // Cast a shadow when cell being pressed.
        shadow(cell)
        
        // Enlarge and transparent.
        enlargeTransparent(cell)
        
        //UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { () -> Void in
        //    cell.alpha = 0.7
        //    cell.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        //}, completion: { finished in
        //    shadow(cell)
        //})
    }

    func changed(_ gesture: UILongPressGestureRecognizer) {
        var location = gesture.location(in: collectionView)
        
        // Lock down the x position
        // https://stackoverflow.com/questions/40116282/preventing-moving-uicollectionviewcell-by-its-center-when-dragging
        location.x = collectionView.frame.width / 2
        
        collectionView?.updateInteractiveMovementTargetPosition(location)
    }

    func end(_ gesture: UILongPressGestureRecognizer) {
        collectionView?.endInteractiveMovement()
        self.movingIndexPath = nil
        
        collectionView?.reloadData()
    }
    
    func cancel(_ gesture: UILongPressGestureRecognizer) {
        collectionView?.cancelInteractiveMovement()
        self.movingIndexPath = nil
    }
}
