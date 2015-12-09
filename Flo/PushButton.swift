//
//  PushButton.swift
//  Flo
//
//  Created by DPC on 15/11/13.
//  Copyright © 2015年 DPC. All rights reserved.
//

import UIKit

@IBDesignable class PushButton: UIButton {
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool = true
    
    override var highlighted:Bool {
        didSet {
            super.highlighted = highlighted
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = plusHeight
        plusPath.moveToPoint(CGPoint(
            x: bounds.width / 2 - plusWidth / 2 + 0.5,
            y: bounds.height / 2 + 0.5))
        
        plusPath.addLineToPoint(CGPoint(
            x: bounds.width / 2 + plusWidth / 2 + 0.5,
            y: bounds.height / 2 + 0.5))
        
        if isAddButton {
            plusPath.moveToPoint(CGPoint(
                x: bounds.width / 2 + 0.5,
                y: bounds.height / 2 - plusWidth / 2 + 0.5))
            
            plusPath.addLineToPoint(CGPoint(
                x: bounds.width / 2 + 0.5,
                y: bounds.height / 2 + plusWidth / 2 + 0.5))
        }
        
        UIColor.whiteColor().setStroke()
        plusPath.stroke();
        
        if self.state == .Highlighted {
            let startColor = UIColor.clearColor()
            let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            let colors = [startColor.CGColor, endColor.CGColor]
            let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), colors, [0, 1])
            
            let center = CGPoint(x: CGRectGetMidX(rect), y: CGRectGetMidY(rect))
            CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(), gradient, center, 0, center, bounds.width/2, [])
        }
    }
}
