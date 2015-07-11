//
//  postViewController.swift
//  Instagram
//
//  Created by Ramesh Vaidyalingam on 11/15/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class postViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var photoSelected : Bool = false

    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var shareText: UITextField!

    @IBAction func chooseImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        self.presentViewController(image, animated: true, completion: nil)
    }

    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    @IBAction func postImage(sender: AnyObject) {
        var error = ""

        if photoSelected == false {
            error = "Please select an image to post"
        } else if shareText.text == "" {
            error = "Please enter a message"
        }
        
        if error != "" {
            displayAlert("Cannot Post Image", error: error)
        } else {

            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()

            var post = PFObject(className: "Post")
            post["Title"] = shareText.text
            post["username"] = PFUser.currentUser().username
            
            post.saveInBackgroundWithBlock({ (success: Bool, error: NSError!) -> Void in
                if success == false {
                    self.displayAlert("Could Not Post Image", error: "Please try again later")
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                } else {
                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    post["imageFile"] = imageFile
                    post.saveInBackgroundWithBlock({ (success : Bool, error : NSError!) -> Void in
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()

                        if success == false {
                            self.displayAlert("Could Not Post Image", error: "Please try again later")
                        } else {
                            println("posted successfully")
                            self.displayAlert("Image Posted", error: "Your image has been posted successfully")
                            self.photoSelected = false
                            self.imageToPost.image = UIImage(named: "UserPlaceholder.png")
                            self.shareText.text = ""
                        }
                    })
                }
            })
        }
    }

    func displayAlert(title : String, error : String) {
        var alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        photoSelected = false
        imageToPost.image = UIImage(named: "UserPlaceholder.png")
        shareText.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageToPost.image = image
        photoSelected = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
