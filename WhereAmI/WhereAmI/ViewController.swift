//
//  ViewController.swift
//  WhereAmI
//
//  Created by Ramesh Vaidyalingam on 10/8/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager : CLLocationManager!

    @IBOutlet weak var latitude: UILabel!
    
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var address: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

        var userLocation: CLLocation = locations[0] as CLLocation
        
        latitude.text = "\(userLocation.coordinate.latitude)"
        longitude.text = "\(userLocation.coordinate.longitude)"
        heading.text = "\(userLocation.course)"
        speed.text = "\(userLocation.speed)"
        altitude.text = "\(userLocation.altitude)"

        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler : {
            (placemarks, error) in
            if((error) != nil) {
                println("Error: \(error)")
            } else {
                var pSub = ""
                
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                
                if((p.subThoroughfare) != nil) {
                    pSub = p.subThoroughfare
                }
                
                self.address.text = "\(pSub) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)"
                
            }
        })
        
        println(userLocation)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

