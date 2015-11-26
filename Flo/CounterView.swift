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
        
        // Draw the arc
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height) / 2
        let arcWidth: CGFloat = 76
        let startAngle: CGFloat = 3 * π / 4
        let endAngle: CGFloat = π / 4
        
        let path = UIBezierPath(arcCenter: center, radius: radius - arcWidth / 2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        if counter > 0 {
            // Draw the outline
            let angleDifference: CGFloat = 2 * π - startAngle + endAngle
            let arcLengthPerGlass = angleDifference / CGFloat(NoOfGlasses)
            let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
            
            let outlinePath = UIBezierPath(arcCenter: center, radius: radius - 2.5, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
            outlinePath.addArcWithCenter(center, radius: radius - arcWidth + 2.5, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
            outlinePath.closePath()
            outlinePath.lineWidth = 5
            outlineColor.setStroke()
            outlinePath.stroke()
        }
    }
}
