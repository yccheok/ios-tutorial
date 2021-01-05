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
    
    let itemContainerView = UIView()
    let kItemInterval: CGFloat = 8
    let kMarginTop: CGFloat = 20
    let kMarginSide: CGFloat = 8
    let kDefaultHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeColorClick(_ sender: Any) {
        print("changeColorClick")
    }
    
    private func initCollectionView(_ collectionViewWidth: CGFloat) -> UICollectionView {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let minItemWidth: CGFloat = 56
        let numberOfCell = collectionViewWidth / minItemWidth
        let width = floor((numberOfCell / floor(numberOfCell)) * minItemWidth)
        let height = width
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.sectionInset = .zero

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
        
        let targetBounds = self.view.bounds
        
        let collectionViewWidth = targetBounds.width - (kMarginSide * 2)
        
        let collectionView: UICollectionView
        
        if self.collectionView == nil {
            self.collectionView = initCollectionView(collectionViewWidth)
            collectionView = self.collectionView!
        } else {
            collectionView = self.collectionView!
        }

        // Use collectionView in rest of the code
        
        var currentPosition: CGFloat = 0
        
        let itemHeight: CGFloat = collectionView.collectionViewLayout.collectionViewContentSize.height
        
        collectionView.frame = CGRect(
            x: kMarginSide,
            y: currentPosition,
            width: collectionViewWidth,
            height: itemHeight)
        
        for subview in self.itemContainerView.subviews {
            subview.removeFromSuperview()
        }
        
        let safeAreaTop: CGFloat
        let safeAreaBottom: CGFloat
        if #available(iOS 11.0, *) {
            safeAreaTop = self.view.safeAreaInsets.top
            safeAreaBottom = self.view.safeAreaInsets.bottom
        } else {
            safeAreaTop = kMarginTop
            safeAreaBottom = 0
        }

        currentPosition = currentPosition + itemHeight + kItemInterval
        
        let positionX: CGFloat = 0
        let positionY: CGFloat = targetBounds.minY + targetBounds.height - currentPosition - safeAreaBottom
        
        self.itemContainerView.frame = CGRect(
          x: positionX,
          y: positionY,
          width: targetBounds.width,
          height: currentPosition)

        // It is important that we only call addSubview after initialize frame, to have proper sizing.
        itemContainerView.addSubview(collectionView)
        
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
