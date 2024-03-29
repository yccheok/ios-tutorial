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
    //view.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
    view.alpha = 0.7
}

func unEnlargeTransparent(_ view: UIView) {
    //view.transform = CGAffineTransform.identity
    view.alpha = 1.0
}

class ReorderCompositionalLayout : UICollectionViewCompositionalLayout {
    override func layoutAttributesForInteractivelyMovingItem(at indexPath: IndexPath, withTargetPosition position: CGPoint) -> UICollectionViewLayoutAttributes {
        let attributes = super.layoutAttributesForInteractivelyMovingItem(at: indexPath as IndexPath, withTargetPosition: position)
        
        attributes.alpha = 0.7
        //attributes.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)

        return attributes
    }
}

class TabInfoSettingsController: UIViewController, TabInfoable {
    enum Section: CaseIterable {
        case main
    }
    
    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<Section, TabInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, TabInfo>
    
    private static let tabInfoSettingsItemCellClassName = String(describing: TabInfoSettingsItemCell.self)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tabInfo: TabInfo?
    
    var dataSource: DataSource?
    
    var movingIndexPath: IndexPath?
    
    var dy: CGFloat = 0.0
    
    var viewController: ViewController? {
        if let parent = self.parent?.parent as? ViewController {
            return parent
        }
        return nil
    }
    
    var filteredTabInfos: [TabInfo] {
        guard let viewController = self.viewController else {
            return []
        }
        
        return viewController.tabInfos.filter({ $0.type != TabInfoType.Settings })
    }
    
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { [weak self] (collectionView, indexPath, tabInfo) -> UICollectionViewCell? in
                guard let self = self else { return nil }
                
                guard let tabInfoSettingsItemCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TabInfoSettingsController.tabInfoSettingsItemCellClassName,
                    for: indexPath) as? TabInfoSettingsItemCell else {
                    return nil
                }
                
                tabInfoSettingsItemCell.delegate = self
                tabInfoSettingsItemCell.reorderDelegate = self
                tabInfoSettingsItemCell.textField.text = tabInfo.getPageTitle()
                tabInfoSettingsItemCell.circleView.backgroundColor = tabInfo.getUIColor()
                
                if indexPath.item == self.movingIndexPath?.item {
                    shadow(tabInfoSettingsItemCell)

                    enlargeTransparent(tabInfoSettingsItemCell)
                } else {
                    unShadow(tabInfoSettingsItemCell)
                    
                    unEnlargeTransparent(tabInfoSettingsItemCell)
                }
                
                return tabInfoSettingsItemCell
            }
        )

        dataSource.reorderingHandlers.canReorderItem = { identifierType in
            return true
        }
        
        dataSource.reorderingHandlers.didReorder = { [weak self] transaction in
            guard let self = self else { return }

            self.viewController?.moveTabInfo(transaction.difference)
        }
        
        return dataSource
    }

    func applySnapshot(_ animatingDifferences: Bool) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])

        snapshot.appendItems(filteredTabInfos, toSection: .main)

        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = layoutConfig()
        
        collectionView.register(
            UINib(nibName: TabInfoSettingsController.tabInfoSettingsItemCellClassName, bundle: nil),
            forCellWithReuseIdentifier: TabInfoSettingsController.tabInfoSettingsItemCellClassName
        )
        
        self.dataSource = makeDataSource()
        
        applySnapshot(false)
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

extension TabInfoSettingsController: TabInfoSettingsItemCellDelegate {
    func crossButtonClick(_ sender: UIButton) {
        let hitPoint = (sender as AnyObject).convert(CGPoint.zero, to: collectionView)
        if let indexPath = collectionView.indexPathForItem(at: hitPoint) {
            // use indexPath to get needed data

            // Remove from single source of truth.
            viewController?.deleteTabInfo(indexPath)

            //
            // Perform UI updating.
            //
            //self.collectionView.deleteItems(at: [indexPath])
            applySnapshot(true)
            
            print("contentOffset -> \(collectionView.contentOffset.y)")
        }
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
        
        dy = gesture.location(in: cell).y - cell.frame.height/2
        
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
        location.y = location.y - dy
        
        collectionView?.updateInteractiveMovementTargetPosition(location)
    }

    func end(_ gesture: UILongPressGestureRecognizer) {
        collectionView?.endInteractiveMovement()
        
        if let movingIndexPath = self.movingIndexPath, let cell = collectionView.cellForItem(at: movingIndexPath as IndexPath) as? TabInfoSettingsItemCell {
            unShadow(cell)
            
            unEnlargeTransparent(cell)
        }
        
        self.movingIndexPath = nil
        
        dy = 0
        
        // Cancel unwanted animation when dropping the cell.
        applySnapshot(false)
    }
    
    func cancel(_ gesture: UILongPressGestureRecognizer) {
        collectionView?.cancelInteractiveMovement()
        
        if let movingIndexPath = self.movingIndexPath, let cell = collectionView.cellForItem(at: movingIndexPath as IndexPath) as? TabInfoSettingsItemCell {
            unShadow(cell)
            
            unEnlargeTransparent(cell)
        }
        
        self.movingIndexPath = nil

        dy = 0
        
        // Cancel unwanted animation when dropping the cell.
        applySnapshot(false)
    }
}
