//
//  ViewController.swift
//  ImageDownload
//
//  Created by Ramesh Vaidyalingam on 10/10/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let url = NSURL.URLWithString("http://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")
//        
//        var error:NSError?
//        
//        var imageData:NSData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
//        
//        var image = UIImage(data: imageData)
//        myImage.image = image
        
        var documentDirectory:String?
        
        var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        if paths.count > 0 {
            if let pathString = paths[0] as? NSString {
                documentDirectory = pathString
            }
        }
        
        var savePath = documentDirectory! + "bach.jpg"
        
//        NSFileManager.defaultManager().createFileAtPath(savePath, contents: imageData, attributes: nil)
        
        myImage.image = UIImage(named: savePath)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

