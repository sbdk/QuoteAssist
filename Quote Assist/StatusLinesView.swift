//
//  ShippingTermLine.swift
//  Quote Assist
//
//  Created by Li Yin on 8/1/16.
//  Copyright © 2016 Li Yin. All rights reserved.
//

import UIKit

@IBDesignable

class StatusLinesView: UIView {
    
    //Creat ShippingTermLine Object
    let shippingTermLinePath = UIBezierPath()
    let shippingTermLineLayer = CAShapeLayer()
    
    //Creat CurrencyLine Object
    let currencyLinePath = UIBezierPath()
    let currencyLineLayer = CAShapeLayer()
    
    //Creat priceUnit Object
    let priceUnitLinePath = UIBezierPath()
    let priceUnitLineLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    
        //Draw path for shippingTermLine
        shippingTermLinePath.moveToPoint(CGPoint(x: 35.0, y: 0))
        shippingTermLinePath.addLineToPoint(CGPoint(x: 35.0, y: bounds.height/2))
        shippingTermLinePath.addLineToPoint(CGPoint(x: bounds.width/2, y: bounds.height))
        
        
        //Draw path for currencyLine
        currencyLinePath.moveToPoint(CGPoint(x: bounds.width/2, y: 0))
        currencyLinePath.addLineToPoint(CGPoint(x: bounds.width/2, y: bounds.height))
        
        
        
        //Draw path for priceUnitLine
        priceUnitLinePath.moveToPoint(CGPoint(x: bounds.width - 35.0, y: 0))
        priceUnitLinePath.addLineToPoint(CGPoint(x: bounds.width - 35.0, y: bounds.height/2))
        priceUnitLinePath.addLineToPoint(CGPoint(x: bounds.width/2, y: bounds.height))
        
        
        configLine(shippingTermLineLayer, linePath: shippingTermLinePath)
        configLine(currencyLineLayer, linePath: currencyLinePath)
        configLine(priceUnitLineLayer, linePath: priceUnitLinePath)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configLine(lineLayer: CAShapeLayer, linePath: UIBezierPath){
        lineLayer.path = linePath.CGPath
        lineLayer.strokeColor = UIColor.greenColor().CGColor
        lineLayer.fillColor = UIColor.clearColor().CGColor
        lineLayer.lineWidth = 3.0
        lineLayer.strokeEnd = 0.0
        layer.addSublayer(lineLayer)
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
        shippingTermLineLayer.strokeEnd = 1.0
        currencyLineLayer.strokeEnd = 1.0
        priceUnitLineLayer.strokeEnd = 1.0
        
        // Do the actual animation
        shippingTermLineLayer.addAnimation(animation, forKey: "shippingTerm")
        currencyLineLayer.addAnimation(animation, forKey: "currency")
        priceUnitLineLayer.addAnimation(animation, forKey: "priceUnit")
    }
}
