//
//  ViewController.swift
//  StopWatch
//
//  Created by Ramesh Vaidyalingam on 10/3/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var counter = NSTimer()
    
    var count = 0
    
    @IBOutlet weak var timer: UILabel!
    
    @IBAction func play(sender: AnyObject) {
        counter = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(sender: AnyObject) {
        counter.invalidate()
    }
    
    @IBAction func reset(sender: AnyObject) {
        count = 0
        counter.invalidate()
        timer.text = "0"
    }
    
    func result() {
        count++
        timer.text = String(count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

