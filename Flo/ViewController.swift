//
//  ViewController.swift
//  Flo
//
//  Created by DPC on 15/10/21.
//  Copyright © 2015年 DPC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var medalView: MedalView!
    
    var isGraphViewShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel.text = String(counterView.counter)
        graphView.hidden = true;
        checkTotal()
    }
    
    @IBAction func buttonPushed(button: PushButton) {
        if button.isAddButton {
            if  counterView.counter < 8 {
                counterView.counter++
            }
        } else if counterView.counter > 0 {
            counterView.counter--
        }
        counterLabel.text = String(counterView.counter)
        if isGraphViewShowing {
            counterViewTap(nil)
        }
        checkTotal()
    }
    
    @IBAction func counterViewTap(sender: UITapGestureRecognizer?) {
        if isGraphViewShowing {
            UIView.transitionFromView(graphView, toView: counterView, duration: 0.6, options: UIViewAnimationOptions.TransitionFlipFromLeft.union(.ShowHideTransitionViews), completion: nil)
        } else {
            UIView.transitionFromView(counterView, toView: graphView, duration: 0.6, options: UIViewAnimationOptions.TransitionFlipFromRight.union(.ShowHideTransitionViews), completion: nil)
            setupGraphDisplay()
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setupGraphDisplay() {
        graphView.graphPoints[graphView.graphPoints.count - 1] = counterView.counter
        graphView.setNeedsDisplay()
        
        maxLabel.text = "\(graphView.graphPoints.maxElement()!)"
        maxLabel.sizeToFit()
        let average = graphView.graphPoints.reduce(0, combine: +) / graphView.graphPoints.count
        averageLabel.text = "Average: \(average)"
        averageLabel.sizeToFit()
        
        // A way to locate the current weekday
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Weekday, fromDate: NSDate())
        var weekday = components.weekday
        let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        
        for i in (1...days.count).reverse() {
            if let dayLabel = graphView.viewWithTag(i) as? UILabel {
                if weekday < 1 {
                    weekday = days.count
                }
                dayLabel.text = days[--weekday]
            }
        }
    }
    
    func checkTotal() {
        if counterView.counter >= 8 {
            medalView.hidden = false
        } else {
            medalView.hidden = true
        }
    }
}
