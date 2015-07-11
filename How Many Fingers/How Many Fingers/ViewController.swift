//
//  ViewController.swift
//  How Many Fingers
//
//  Created by Ramesh Vaidyalingam on 10/2/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNumberInput: UITextField!
    @IBOutlet weak var message: UILabel!

    @IBAction func guess(sender: AnyObject) {
        var uNumber = userNumberInput.text.toInt()
        
        if((uNumber) != nil) {
            var rNumber = Int(arc4random() % 6)
            if(uNumber == rNumber) {
                message.text = "You got it right"
            } else {
                message.text = "That wasn't right"
            }
        }
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

