//
//  CircleView.swift
//  experiment-subview
//
//  Created by Cheok Yan Cheng on 04/01/2021.
//

import UIKit

class CircleView: UICollectionViewCell {
    private var _color: UIColor = UIColor.clear
    var color: UIColor {
        set {
            _color = newValue
            setNeedsDisplay()
        }
        get {
            _color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {return}

        // Shrink the rect size so that it becomes square.
        let minSize = min(rect.width, rect.height)
        let insetRect = rect.insetBy(dx: (rect.width-minSize)/2.0, dy: (rect.height-minSize)/2.0)
        
        context.clear(rect)
        context.addEllipse(in: insetRect)
        context.setFillColor(color.cgColor)
        context.fillPath()
    }


}
