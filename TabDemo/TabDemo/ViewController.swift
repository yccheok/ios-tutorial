//
//  ViewController.swift
//  TabDemo
//
//  Created by guest2 on 03/09/2020.
//  Copyright © 2020 yocto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let tabInfoCellClassName = String(describing: TabInfoCell.self)
    
    @IBOutlet weak var tabCollectionView: UICollectionView!
    @IBOutlet weak var tabBottomView: UIView!
    
    private var selectedTabInfoIndex: Int = -1
    
    private var pageViewController: UIPageViewController!
    
    private var originalSize: CGSize?
    
    // TODO: String localization.
    var tabInfos = [
        TabInfo(id: 0, type: .All, name: nil, colorIndex: 0),
        TabInfo(id: 1, type: .Calendar, name: nil, colorIndex: 1),
        TabInfo(id: 2, type: .Custom, name: "Home2", colorIndex: 2),
        TabInfo(id: 3, type: .Custom, name: "Work3", colorIndex: 3),
        TabInfo(id: 4, type: .Custom, name: "Work4", colorIndex: 4),
        TabInfo(id: 5, type: .Custom, name: "Work5", colorIndex: 5),
        TabInfo(id: 6, type: .Custom, name: "Work6", colorIndex: 6),
        TabInfo(id: 7, type: .Custom, name: "Work7", colorIndex: 7),
        TabInfo(id: 8, type: .Custom, name: "Work8", colorIndex: 8),
        TabInfo(id: 9, type: .Custom, name: "Home9", colorIndex: 9),
        TabInfo(id: 10, type: .Custom, name: "Work10", colorIndex: 10),
        TabInfo(id: 11, type: .Custom, name: "Work11", colorIndex: 11),
        TabInfo(id: 12, type: .Custom, name: "Work12", colorIndex: 12),
        TabInfo(id: 13, type: .Custom, name: "Work13", colorIndex: 13),
        TabInfo(id: 14, type: .Custom, name: "Work14", colorIndex: 14),
        TabInfo(id: 15, type: .Custom, name: "15", colorIndex: 15),
        TabInfo(id: 16, type: .Settings, name: nil, colorIndex: 16)
    ]
    
    private func getIndex(_ tabInfo: TabInfo?) -> Int {
        guard let tabInfo = tabInfo else {
            return -1
        }
        
        for (index, _tabInfo) in tabInfos.enumerated() {
            if tabInfo.id == _tabInfo.id {
                return index
            }
        }
        
        return -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabCollectionView.collectionViewLayout = layoutConfig()
        
        tabCollectionView.showsHorizontalScrollIndicator = false
        tabCollectionView.showsVerticalScrollIndicator = false
        
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        // TODO: Testing only.
        selectTab(9)
        
        hideKeyboardWhenTappedAround()
    }
    
    func deleteTabInfo(_ indexPath: IndexPath) {
        tabInfos.remove(at: indexPath.row)
        
        tabCollectionView.deleteItems(at: [indexPath])
        
        // Clear left/ right cached view controllers - https://stackoverflow.com/a/21624169/72437
        pageViewController.dataSource = nil
        pageViewController.dataSource = self

        // Don't forget to adjust the selection index.
        if indexPath.row < self.selectedTabInfoIndex {
            self.selectedTabInfoIndex -= 1
        }
    }
    
    func moveTabInfo(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        let temp = tabInfos[indexPath.item]
        tabInfos.remove(at: indexPath.item)
        tabInfos.insert(temp, at: newIndexPath.item)
        
        tabCollectionView.moveItem(at: indexPath, to: newIndexPath)
        
        // Clear left/ right cached view controllers - https://stackoverflow.com/a/21624169/72437
        pageViewController.dataSource = nil
        pageViewController.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.originalSize == nil {
                let originalSize = self.view.frame.size
                self.originalSize = originalSize
                self.view.frame.size = CGSize(
                    width: originalSize.width,
                    height: originalSize.height - keyboardSize.height
                )
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let originalSize = self.originalSize {
            self.view.frame.size = originalSize
            self.originalSize = nil
        }
    }
    
    private func getIndexPath(_ index: Int) -> IndexPath {
        return IndexPath(item: index, section: 0)
    }
    
    private func selectTab(_ index: Int) {
        let indexPath = getIndexPath(index)
        self.collectionView(self.tabCollectionView, didSelectItemAt: indexPath)
        
        DispatchQueue.main.async {
            self.tabCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
            self.tabCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let pageController as UIPageViewController:
            self.pageViewController = pageController
            
        default:
            break
        }
    }
    
    private func updateTabBottomView() {
        self.tabBottomView.backgroundColor = tabInfos[selectedTabInfoIndex].getUIColor()
    }
    
    private func layoutConfig() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout (sectionProvider: { (sectionNumber, env) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(CGFloat(Constants.MINIMUM_TOUCH_AREA_SIZE)),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(CGFloat(Constants.MINIMUM_TOUCH_AREA_SIZE)),
                heightDimension: .absolute(CGFloat(Constants.MINIMUM_TOUCH_AREA_SIZE))
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 1
            return section
        }, configuration: configuration)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let tabCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: tabInfoCellClassName, for: indexPath) as? TabInfoCell {
            let tabInfo = tabInfos[indexPath.row]
            let selected = indexPath.row == self.selectedTabInfoIndex
            tabCollectionViewCell.update(tabInfo, selected)
            return tabCollectionViewCell
        }
        
        return UICollectionViewCell()
    }
    
    private func shouldSetViewControllers() -> Bool {
        guard let viewControllers = self.pageViewController.viewControllers else { return true }
        guard viewControllers.count > 0 else { return true }
        guard let tabInfoable = viewControllers[0] as? TabInfoable else { return true }
        return tabInfoable.tabInfo != tabInfos[self.selectedTabInfoIndex]
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oldSelectedTabInfoIndex = self.selectedTabInfoIndex
        self.selectedTabInfoIndex = indexPath.row
        
        updateTabBottomView()
            
        let direction = self.selectedTabInfoIndex > oldSelectedTabInfoIndex ?
            UIPageViewController.NavigationDirection.forward :
            UIPageViewController.NavigationDirection.reverse
        
        if shouldSetViewControllers() {
            self.pageViewController.setViewControllers([viewController(At: self.selectedTabInfoIndex)!], direction: direction, animated: true, completion: nil)
            self.tabCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func debug() {
        if tabInfos.count < 2 {
            return
        }
        
        let index = tabInfos.count-2
        tabInfos.remove(at: index)

        self.tabCollectionView.reloadData()
        DispatchQueue.main.async() {
            let indexPath = self.getIndexPath(self.tabInfos.count-1)
            self.tabCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            self.tabCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        }

        // Clear left/ right cached view controllers - https://stackoverflow.com/a/21624169/72437
        pageViewController.dataSource = nil
        pageViewController.dataSource = self

        // Don't forget to adjust the selection index.
        if index < self.selectedTabInfoIndex {
            selectedTabInfoIndex -= 1
        }
    }
}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func viewController(At index: Int) -> UIViewController? {
        if ((index < 0) || (index >= self.tabInfos.count)) {
            return nil
        }
        
        switch tabInfos[index].type {
        case .All:
            return dashboardController(index)
        case .Calendar:
            return calendarController(index)
        case .Custom:
            return dashboardController(index)
        case .Settings:
            return tabInfoSettingsController(index)
        }
    }
    
    private func dashboardController(_ index: Int) -> UIViewController? {
        let className = String(describing: DashboardController.self)
        let dashboardController = DashboardController(nibName: className, bundle: nil)
        dashboardController.tabInfo = tabInfos[index]
        return dashboardController
    }
    
    private func calendarController(_ index: Int) -> UIViewController? {
        let className = String(describing: CalendarController.self)
        let calendarController = CalendarController(nibName: className, bundle: nil)
        calendarController.tabInfo = tabInfos[index]
        return calendarController
    }
    
    private func tabInfoSettingsController(_ index: Int) -> UIViewController? {
        let className = String(describing: TabInfoSettingsController.self)
        let tabInfoSettingsController = TabInfoSettingsController(nibName: className, bundle: nil)
        tabInfoSettingsController.tabInfo = tabInfos[index]
        return tabInfoSettingsController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = getIndex((viewController as! TabInfoable).tabInfo)
        
        if index <= 0 {
            return nil
        }
        
        index -= 1

        return self.viewController(At: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = getIndex((viewController as! TabInfoable).tabInfo)
        
        if index < 0 || index >= tabInfos.count-1 {
            return nil
        }
        
        index += 1

        return self.viewController(At: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished {
            if completed {
                let tabInfo = (pageViewController.viewControllers!.first as! TabInfoable).tabInfo
                let pageIndex = getIndex(tabInfo)
                if (pageIndex < 0) {
                    return
                }
                let indexPath = getIndexPath(pageIndex)
                tabCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
                tabCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                
                self.selectedTabInfoIndex = pageIndex
                updateTabBottomView()
            }
        }
        
    }
}

