//
//  GraphView.swift
//  Flo
//
//  Created by DPC on 15/11/27.
//  Copyright © 2015年 DPC. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    var graphPoints: [Int] = [4, 2, 6, 4, 5, 8, 3]
    
    override func drawRect(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        // Draw the corner
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: 8, height: 8))
        path.addClip()
        
        // Draw the gradient background
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0, 1]
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        
        var startPoint = CGPoint.zero
        var endPoint = CGPoint(x: 0, y: height)
        let options: CGGradientDrawingOptions = []
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, options)
        
        // Draw the clipping graph line and points
        let margin: CGFloat = 20
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacer = (width - margin * 2 - 4) / CGFloat(self.graphPoints.count - 1)
            var x: CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
        
        let topBorder: CGFloat = 60
        let bottomBorder: CGFloat = 50
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints.maxElement()!
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            var y: CGFloat = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            y = graphHeight + topBorder - y
            return y
        }
        
        let graphPath = UIBezierPath()
        graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            graphPath.addLineToPoint(nextPoint)
        }
        
        // Save the current context state
        CGContextSaveGState(context)
        
        let clippingPath = graphPath.copy() as! UIBezierPath
        clippingPath.addLineToPoint(CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLineToPoint(CGPoint(x: columnXPoint(0), y: height))
        clippingPath.closePath()
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(maxValue)
        startPoint = CGPoint(x: margin, y: highestYPoint)
        endPoint = CGPoint(x: margin, y: height)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, options)
        
        UIColor.whiteColor().setStroke()
        graphPath.lineWidth = 3
        graphPath.stroke()
        
        // Restore the former context state
        CGContextRestoreGState(context)
        
        for i in 0 ..< graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= 3
            point.y -= 3
            
            let circle = UIBezierPath(ovalInRect: CGRect(origin: point, size: CGSize(width: 6, height: 6)))
            UIColor.whiteColor().setFill()
            circle.fill()
        }
        
        // Draw the horizontal lines
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: margin, y: topBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin, y: topBorder))
        
        linePath.moveToPoint(CGPoint(x: margin, y: topBorder + graphHeight / 2))
        linePath.addLineToPoint(CGPoint(x: width - margin, y: topBorder + graphHeight / 2))
        
        linePath.moveToPoint(CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLineToPoint(CGPoint(x: width - margin, y: height - bottomBorder))
        
        UIColor(white: 1.0, alpha: 0.4).setStroke()
        linePath.lineWidth = 1
        linePath.stroke()
    }
}
