//
//  ViewController.swift
//  Flo
//
//  Created by DPC on 15/10/21.
//  Copyright © 2015年 DPC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterLabel.text = String(counterView.counter)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
}
