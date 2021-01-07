//
//  ViewController.swift
//  experiment-subview
//
//  Created by Cheok Yan Cheng on 04/01/2021.
//

import UIKit

class ViewController: UIViewController {
    private let CIRCLE_VIEW = "CIRCLE_VIEW"
    
    var collectionView: UICollectionView?
    var colorPickerViewController: ColorPickerViewController?
    
    let itemContainerView = UIView()
    let kItemInterval: CGFloat = 8
    let kMarginTop: CGFloat = 20
    let kMarginSide: CGFloat = 8
    let kDefaultHeight: CGFloat = 44
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("ViewController viewWillTransition")

        coordinator.animate(alongsideTransition: { (context) in
            // During rotation
        }) { (context) in

            let targetBounds = self.view.bounds
            
            let safeAreaLeft: CGFloat
            let safeAreaWidth: CGFloat
            let safeAreaTop: CGFloat
            let safeAreaBottom: CGFloat
            if #available(iOS 11.0, *) {
                safeAreaLeft = self.view.safeAreaInsets.left
                safeAreaWidth = self.view.safeAreaLayoutGuide.layoutFrame.width
                safeAreaTop = self.view.safeAreaInsets.top
                safeAreaBottom = self.view.safeAreaInsets.bottom
            } else {
                safeAreaLeft = 0
                safeAreaWidth = targetBounds.width
                safeAreaTop = self.kMarginTop
                safeAreaBottom = 0
            }
            
            let positionX: CGFloat = safeAreaLeft
            let positionY: CGFloat = targetBounds.minY + targetBounds.height - self.itemContainerView.frame.height - safeAreaBottom
            
            self.itemContainerView.frame = CGRect(
              x: positionX,
              y: positionY,
              width: safeAreaWidth,
                height: self.itemContainerView.frame.height)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeColorClick(_ sender: Any) {
        print("changeColorClick")
    }
    
    private func initCollectionView(_ collectionViewWidth: CGFloat) -> UICollectionView {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 4
        
        let maxItemWidth: CGFloat = 56
        let numberOfCell = collectionViewWidth / maxItemWidth
        let effectiveCollectionViewWidth = (collectionViewWidth - (max(1, floor(numberOfCell))-1)*flowLayout.minimumInteritemSpacing*2)
        let width = effectiveCollectionViewWidth / floor(numberOfCell)
        let height = width
        
        flowLayout.minimumLineSpacing = 8
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        // Use 0 for height. We will adjust it later.
        let frame = CGRect(
            x: 0,
            y: 0,
            width: collectionViewWidth,
            height: 0)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        
        collectionView.register(CircleView.self, forCellWithReuseIdentifier: CIRCLE_VIEW)

        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        print("click")
        
        if colorPickerViewController != nil {
            colorPickerViewController!.willMove(toParent: nil)
        }
        for subview in self.itemContainerView.subviews {
            subview.removeFromSuperview()
        }
        if colorPickerViewController != nil {
            colorPickerViewController!.removeFromParent()
            colorPickerViewController = nil
        }
        
        let targetBounds = self.view.bounds
        
        let colorPickerViewController: ColorPickerViewController
        
        if self.colorPickerViewController == nil {
            self.colorPickerViewController = ColorPickerViewController(nibName: "ColorPickerViewController", bundle: nil)
            colorPickerViewController = self.colorPickerViewController!
        } else {
            colorPickerViewController = self.colorPickerViewController!
        }

        // Use collectionView in rest of the code
        
        var currentPosition: CGFloat = 0
        
        let itemHeight: CGFloat = 200
        
        print("self.view.bounds -> \(self.view.bounds)")
        print("self.view.safeAreaInsets -> \(self.view.safeAreaInsets)")

        //self.view.backgroundColor = UIColor.brown

        let safeAreaLeft: CGFloat
        let safeAreaWidth: CGFloat
        let safeAreaTop: CGFloat
        let safeAreaBottom: CGFloat
        if #available(iOS 11.0, *) {
            safeAreaLeft = self.view.safeAreaInsets.left
            safeAreaWidth = self.view.safeAreaLayoutGuide.layoutFrame.width
            safeAreaTop = self.view.safeAreaInsets.top
            safeAreaBottom = self.view.safeAreaInsets.bottom
        } else {
            safeAreaLeft = 0
            safeAreaWidth = targetBounds.width
            safeAreaTop = kMarginTop
            safeAreaBottom = 0
        }

        let colorPickerViewControllerWidth = safeAreaWidth - (kMarginSide * 2)
        
        colorPickerViewController.view.frame = CGRect(
            x: kMarginSide,
            y: currentPosition,
            width: colorPickerViewControllerWidth,
            height: itemHeight)
        
        currentPosition = currentPosition + itemHeight + kItemInterval
        
        let positionX: CGFloat = safeAreaLeft
        let positionY: CGFloat = targetBounds.minY + targetBounds.height - currentPosition - safeAreaBottom
        
        self.itemContainerView.frame = CGRect(
          x: positionX,
          y: positionY,
          width: safeAreaWidth,
          height: currentPosition)
        
        // It is important that we only call addSubview after initialize frame, to have proper sizing.
        self.addChild(colorPickerViewController)
        itemContainerView.addSubview(colorPickerViewController.view)
        colorPickerViewController.didMove(toParent: self)
        
        self.view.addSubview(self.itemContainerView)
        
        self.itemContainerView.transform = CGAffineTransform(translationX: 0, y: currentPosition)
        UIView.animate(withDuration: 0.4,
          delay: 0,
          usingSpringWithDamping: 1,
          initialSpringVelocity: 0,
          options: .curveEaseOut,
          animations: { () -> Void in
            self.itemContainerView.transform = CGAffineTransform.identity
          }, completion: nil)
    }
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CIRCLE_VIEW, for: indexPath) as! CircleView
        
        cell.color = UIColor.red
        
        return cell
    }
    
    
}
