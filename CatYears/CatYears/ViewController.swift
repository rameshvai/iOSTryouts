//
//  ViewController.swift
//  CatYears
//
//  Created by Ramesh Vaidyalingam on 10/2/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var catAge: UITextField!

    @IBOutlet weak var message: UILabel!

    @IBAction func buttonAction(sender: AnyObject) {

        var age = catAge.text.toInt()
        
        if((age) != nil) {
            age = age! * 7
            message.text = "Your cat is \(age!) years old"
        } else {
            message.text = "Please enter number in the box"
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

