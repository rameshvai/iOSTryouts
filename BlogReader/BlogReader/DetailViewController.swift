//
//  DetailViewController.swift
//  BlogReader
//
//  Created by Ramesh Vaidyalingam on 10/11/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
//            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        
        webview.loadHTMLString(activeItem, baseURL: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

