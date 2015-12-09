//
//  BackgroundView.swift
//  Flo
//
//  Created by DPC on 15/12/7.
//  Copyright © 2015年 DPC. All rights reserved.
//

import UIKit

@IBDesignable class BackgroundView: UIView {
    @IBInspectable var lightColor: UIColor = UIColor.orangeColor()
    @IBInspectable var darkColor: UIColor = UIColor.yellowColor()
    @IBInspectable var patternSize: CGFloat = 30
    
    override func drawRect(rect: CGRect) {
        
        // Draw the meta pattern image
        let drawSize = CGSize(width: patternSize, height: patternSize)
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0)
        let drawingContext = UIGraphicsGetCurrentContext()
        lightColor.setFill()
        CGContextFillRect(drawingContext, CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
        
        //        let trianglePath = UIBezierPath()
        //        trianglePath.moveToPoint(CGPoint(x: drawSize.width / 2, y: 0))
        //        trianglePath.addLineToPoint(CGPoint(x: 0, y: drawSize.height / 2))
        //        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height / 2))
        //        
        //        trianglePath.moveToPoint(CGPoint(x: 0, y: drawSize.height / 2))
        //        trianglePath.addLineToPoint(CGPoint(x: drawSize.width / 2, y: drawSize.height))
        //        trianglePath.addLineToPoint(CGPoint(x: 0, y: drawSize.height))
        //        
        //        trianglePath.moveToPoint(CGPoint(x: drawSize.width, y: drawSize.height / 2))
        //        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height))
        //        trianglePath.addLineToPoint(CGPoint(x: drawSize.width / 2, y: drawSize.height))
        //        darkColor.setFill()
        //        trianglePath.fill()
        
        let circlePath = UIBezierPath(ovalInRect: CGRect(x: drawSize.width / 4, y: drawSize.height / 4, width: drawSize.width / 2, height: drawSize.height / 2))
        darkColor.setFill()
        circlePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let context = UIGraphicsGetCurrentContext()
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }
}
