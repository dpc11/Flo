//
//  MedalView.swift
//  Flo
//
//  Created by DPC on 15/12/8.
//  Copyright © 2015年 DPC. All rights reserved.
//

import UIKit

class MedalView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        image = creatMedalImage()
    }
    
    func creatMedalImage() -> UIImage {
        let size = CGSize(width: 120, height: 200)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        let darkGoldColor = UIColor(red: 0.6, green: 0.5, blue: 0.15, alpha: 1)
        let midGoldColor = UIColor(red: 0.86, green: 0.73, blue: 0.3, alpha: 1)
        let lightGoldColor = UIColor(red: 1, green: 0.98, blue: 0.9, alpha: 1)
        
        let shadow:UIColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        let shadowOffset = CGSize(width: 2, height: 2)
        let shadowBlurRadius: CGFloat = 5
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor)
        
        // Add subsequent drawing into a group
        CGContextBeginTransparencyLayer(context, nil)
        
        let lowerRibbonPath = UIBezierPath()
        lowerRibbonPath.moveToPoint(CGPoint(x: 0, y: 0))
        lowerRibbonPath.addLineToPoint(CGPoint(x: 40, y: 0))
        lowerRibbonPath.addLineToPoint(CGPoint(x: 78, y: 70))
        lowerRibbonPath.addLineToPoint(CGPoint(x: 38, y: 70))
        lowerRibbonPath.closePath()
        UIColor.redColor().setFill()
        lowerRibbonPath.fill()
        
        let claspPath = UIBezierPath(roundedRect: CGRect(x: 36, y: 62, width: 43, height: 20), cornerRadius: 5)
        claspPath.lineWidth = 5
        darkGoldColor.setStroke()
        claspPath.stroke()
        
        CGContextSaveGState(context)
        let medallionPath = UIBezierPath(ovalInRect: CGRect(x: 8, y: 72, width: 100, height: 100))
        medallionPath.addClip()
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [darkGoldColor.CGColor, midGoldColor.CGColor, lightGoldColor.CGColor], [0, 0.51, 1])
        CGContextDrawLinearGradient(context, gradient, CGPoint(x: 40, y: 60), CGPoint(x: 100, y: 160), [])
        CGContextRestoreGState(context)
        
        // It's different in sequences of affineTransform
        var transform = CGAffineTransformMakeTranslation(11.2, 24.4)
        transform = CGAffineTransformScale(transform, 0.8, 0.8)
        //var transform = CGAffineTransformMakeScale(0.8, 0.8)
        //transform = CGAffineTransformTranslate(transform, 14.5, 30.5)
        medallionPath.lineWidth = 2
        medallionPath.applyTransform(transform)
        medallionPath.stroke()
        
        let upperRibbonPath = UIBezierPath()
        upperRibbonPath.moveToPoint(CGPoint(x: 68, y: 0))
        upperRibbonPath.addLineToPoint(CGPoint(x: 108, y: 0))
        upperRibbonPath.addLineToPoint(CGPoint(x: 78, y: 70))
        upperRibbonPath.addLineToPoint(CGPoint(x: 38, y: 70))
        upperRibbonPath.closePath()
        UIColor.blueColor().setFill()
        upperRibbonPath.fill()
        
        let numberOne = "1"
        let numberOneRect = CGRect(x: 47, y: 100, width: 50, height: 50)
        let font = UIFont(name: "Academy Engraved LET", size: 60)
        let numberOneAttributes = [NSFontAttributeName: font!, NSForegroundColorAttributeName: darkGoldColor]
        numberOne.drawInRect(numberOneRect, withAttributes: numberOneAttributes)
        
        CGContextEndTransparencyLayer(context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
