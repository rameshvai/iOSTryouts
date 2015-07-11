//
//  ViewController.swift
//  isItPrime
//
//  Created by Ramesh Vaidyalingam on 10/3/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var message: UILabel!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        var userInt = userInput.text.toInt()
        var isPrime = true
        if((userInt) != nil) {
            if(userInt < 1) {
                message.text = "Please enter a positive integer"
            } else {
                if(userInt == 1) {
                    message.text = "1 is not a prime"
                } else {
                    var j = (userInt! / 2) + 1
                    for var i = 2; i < j; ++i {
                        if(userInt! % i == 0) {
                            isPrime = false
                            break
                        }
                    }
                    if(isPrime == true) {
                        message.text = "That number is prime!"
                    } else {
                        message.text = "That number is not a prime!"
                    }
                }
            }
        } else {
            message.text = "Please enter a valid integer"
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

