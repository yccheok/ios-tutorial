//
//  ViewController.swift
//  experiment-subview
//
//  Created by Cheok Yan Cheng on 04/01/2021.
//

import UIKit

class ViewController: UIViewController {

    let itemContainerView = UIView()
    let kItemInterval: CGFloat = 8
    let kMarginTop: CGFloat = 20
    let kMarginSide: CGFloat = 8
    let kDefaultHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonClick(_ sender: Any) {
        print("click")
        
        guard let customView2 = UINib(nibName: "CustomView2", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? CustomView2 else {
            return
        }

        var currentPosition: CGFloat = 0
        
        let itemHeight: CGFloat = 100
        
        let targetBounds = self.view.bounds
        
        customView2.frame = CGRect(
            x: kMarginSide,
            y: currentPosition,
            width: targetBounds.width - (kMarginSide * 2),
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

        itemContainerView.addSubview(customView2)
        
        let positionX: CGFloat = 0
        let positionY: CGFloat = targetBounds.minY + targetBounds.height - currentPosition - safeAreaBottom
        
        self.itemContainerView.frame = CGRect(
          x: positionX,
          y: positionY,
          width: targetBounds.width,
          height: currentPosition)
        
        self.view.addSubview(self.itemContainerView)
        
        /*
        self.itemContainerView.transform = CGAffineTransform(translationX: 0, y: currentPosition)
        UIView.animate(withDuration: 0.4,
          delay: 0,
          usingSpringWithDamping: 1,
          initialSpringVelocity: 0,
          options: .curveEaseOut,
          animations: { () -> Void in
            self.itemContainerView.transform = CGAffineTransform.identity
          }, completion: nil)*/
    }
}

