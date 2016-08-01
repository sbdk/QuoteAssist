//
//  ShippingTermLine.swift
//  Quote Assist
//
//  Created by Li Yin on 8/1/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import UIKit

@IBDesignable

class ShippingTermLine: UILabel {
    
    let linePath = UIBezierPath()
    let lineLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    
        linePath.moveToPoint(CGPoint(x: bounds.width/2, y: 0))
        linePath.addLineToPoint(CGPoint(x: bounds.width/2, y: bounds.height/2))
        linePath.addLineToPoint(CGPoint(x: bounds.width, y: bounds.height))
        
        lineLayer.path = linePath.CGPath
        lineLayer.strokeColor = UIColor.greenColor().CGColor
        lineLayer.fillColor = UIColor.clearColor().CGColor
        lineLayer.lineWidth = 3.0
        lineLayer.strokeEnd = 0.0
        
        layer.addSublayer(lineLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animateLine(duration: NSTimeInterval) {

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration
        animation.duration = duration
        
        // Animate from 0 (start point) to 1 (end point)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Set the line's strokeEnd property to 1.0 now so that it's the
        // right value when the animation ends.
        lineLayer.strokeEnd = 1.0
        
        // Do the actual animation
        lineLayer.addAnimation(animation, forKey: "animateLine")
    }
}
