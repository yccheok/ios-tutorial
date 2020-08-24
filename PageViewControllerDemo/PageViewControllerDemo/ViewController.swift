//
//  ViewController.swift
//  PageViewControllerDemo
//
//  Created by Tee Shuwn Yuan on 23/08/2020.
//  Copyright © 2020 Tee Shuwn Yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    let dataSource = ["View Controller One", "View Controller Two", "View Controller Three", "View Controller Four"]
    
    var currentViewControllerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
    }

    func configurePageViewController() {
        let identifier = String(describing: CustomPageViewController.self)
        
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as? CustomPageViewController else {
            return
        }
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(pageViewController.view)
        
        let views: [String: Any] = ["pageView": pageViewController.view]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                 options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                 options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }

    func detailViewControllerAt(index: Int) -> DataViewController? {
        if index >= dataSource.count || dataSource.count == 0 {
            return nil
        }
        
        let identifier = String(describing: DataViewController.self)
        
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as? DataViewController else {
            return nil
        }
        
        dataViewController.index = index
        
        dataViewController.displayText = dataSource[index]
        
        return dataViewController
    }
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? DataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        
        currentViewControllerIndex = currentIndex
        
        if (currentIndex == 0) {
            return nil
        }
        
        currentIndex -= 1
        
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? DataViewController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }

        if (currentIndex == dataSource.count-1) {
            return nil
        }
        
        currentIndex += 1
        
        currentViewControllerIndex = currentIndex
        
        return detailViewControllerAt(index: currentIndex)
    }
}

