//
//  ViewController.swift
//  Tinder
//
//  Created by Ramesh Vaidyalingam on 12/3/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func signin(sender: AnyObject) {
        var permissions = ["public_profile"]
        
        PFFacebookUtils.logInWithPermissions(permissions, {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                println("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                println("User signed up and logged in through Facebook!")
            } else {
                println("User logged in through Facebook!")
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if PFUser.currentUser().username != nil {
            println("User logged in")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

