//
//  ViewController.swift
//  LearningMaps
//
//  Created by Ramesh Vaidyalingam on 10/8/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
//    40.748676, -73.985659

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var latitude:CLLocationDegrees = 40.748676
        var longitude:CLLocationDegrees = -73.985659
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        
        var span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)

        var region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

