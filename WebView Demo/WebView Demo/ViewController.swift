//
//  ViewController.swift
//  WebView Demo
//
//  Created by Ramesh Vaidyalingam on 10/10/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        var url = NSURL(string: "https://www.google.com")
//        var request = NSURLRequest(URL: url)
//        webview.loadRequest(request)

        var html = "<html><head></head><body><h1>Hello World!</h1></body></html>"
        webview.loadHTMLString(html, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

