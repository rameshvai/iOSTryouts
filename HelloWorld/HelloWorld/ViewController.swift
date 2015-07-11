//
//  ViewController.swift
//  HelloWorld
//
//  Created by Ramesh Vaidyalingam on 9/29/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!

    @IBAction func buttonPressed(sender: AnyObject) {
        println("Hello World!!!")
        myLabel.text = "It Worked!!!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

