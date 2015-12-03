//
//  CounterView.swift
//  Flo
//
//  Created by DPC on 15/11/24.
//  Copyright © 2015年 DPC. All rights reserved.
//

import UIKit

let NoOfGlasses = 8
let π: CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {
    @IBInspectable var counter: Int = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        // Draw the arc
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius: CGFloat = min(width, height) / 2
        let arcWidth: CGFloat = 76
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        let path = UIBezierPath(arcCenter: center, radius: radius - arcWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference: CGFloat = 2 * π - startAngle + endAngle
        let arcAnglePerGlass = angleDifference / CGFloat(NoOfGlasses)
        if counter > 0 {
            // Draw the outline
            let outlineEndAngle = arcAnglePerGlass * CGFloat(counter) + startAngle
            
            let outlinePath = UIBezierPath(arcCenter: center, radius: radius - 2.5, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
            outlinePath.addArcWithCenter(center, radius: radius - arcWidth + 2.5, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
            outlinePath.closePath()
            outlinePath.lineWidth = 5
            outlineColor.setStroke()
            outlinePath.stroke()
        }
        
        // Draw the markers to indicate
        let context = UIGraphicsGetCurrentContext()
        let markerWidth: CGFloat = 5
        let markerHeight: CGFloat = 12
        let markerPath = UIBezierPath(rect: CGRect(x: width / 2 - markerWidth / 2, y: height / 2 - min(width, height) / 2, width: markerWidth, height: markerHeight))
        
        outlineColor.setFill()
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, width / 2, height / 2)
        CGContextRotateCTM(context, angleDifference / 2)
        for i in 0...NoOfGlasses {
            CGContextSaveGState(context)
            CGContextRotateCTM(context, -arcAnglePerGlass * CGFloat(i))
            CGContextTranslateCTM(context, -width / 2, -height / 2)
            markerPath.fill()
            CGContextRestoreGState(context)
        }
        
        CGContextRestoreGState(context)
    }
}
