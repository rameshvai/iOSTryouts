//
//  ViewController.swift
//  Instagram
//
//  Created by Ramesh Vaidyalingam on 11/4/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    var signupActive = true

    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signupToggle: UIButton!
    @IBOutlet weak var alreadyRegistered: UILabel!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signupToggleAction(sender: AnyObject) {
        if signupActive == true {
            signupActive = false
            signupLabel.text = "Use the form below to log in"
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            alreadyRegistered.text = "Not registered?"
            signupToggle.setTitle("Sign Up", forState: UIControlState.Normal)
        } else {
            signupActive = true
            signupLabel.text = "Use the form below to sign up"
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            alreadyRegistered.text = "Already registered?"
            signupToggle.setTitle("Log In", forState: UIControlState.Normal)
        }
    }

    @IBAction func signup(sender: AnyObject) {
        var errorText = ""

        if username.text == "" || password.text == "" {
            
            errorText = "Please enter a username and password"
            
        }
        
        if errorText != "" {
            displayAlert("Error in Form", message: errorText)
        } else {
            var user = PFUser()
            user.username = username.text
            user.password = password.text
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            if signupActive == true {
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool!, signupError: NSError!) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signupError == nil {
                        // Hooray! Let them use the app now.
                        self.performSegueWithIdentifier("jumpToUserTable", sender: self)
                    } else {
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            errorText = errorString
                        } else {
                            errorText = "Please try again later"
                        }
                        self.displayAlert("Could Not Sign Up", message: errorText)
                    }
                }
            } else {
                PFUser.logInWithUsernameInBackground(username.text, password:password.text) {
                    (user: PFUser!, signupError: NSError!) -> Void in

                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()

                    if signupError == nil {
                        // Do stuff after successful login.
                        println("user logged ind \(user)")
                        self.performSegueWithIdentifier("jumpToUserTable", sender: self)
                    } else {
                        // The login failed. Check error to see why.
                        if let errorString = signupError.userInfo?["error"] as? NSString {
                            errorText = errorString
                        } else {
                            errorText = "Please try again later"
                        }
                        self.displayAlert("Could Not Log In", message: errorText)
                    }
                }
            }
        }
    }
    
    func displayAlert(title : String, message : String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        println(PFUser.currentUser())
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("jumpToUserTable", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
}

