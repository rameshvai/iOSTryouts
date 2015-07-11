//
//  ViewController.swift
//  MemorablePlaces
//
//  Created by Ramesh Vaidyalingam on 10/9/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!

    @IBOutlet weak var findMe: UIBarButtonItem!
    
    @IBOutlet weak var myMap: MKMapView!

    @IBAction func findMePressed(sender: AnyObject) {
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest

        if activePlace == -1 {
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else {
            let lat = NSString(string: places[activePlace]["lat"]!).doubleValue
            let lon = NSString(string: places[activePlace]["lon"]!).doubleValue
            
            var latitude:CLLocationDegrees = lat
            var longitude:CLLocationDegrees = lon
            
            var latDelta:CLLocationDegrees = 0.01
            var lonDelta:CLLocationDegrees = 0.01
            
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
            var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            myMap.setRegion(region, animated: true)
            
            var annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            annotation.title = places[activePlace]["name"]
            myMap.addAnnotation(annotation)
        }
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 2.0
        myMap.addGestureRecognizer(uilpgr)
    }

    func action(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Began {
            
            var touchPoint = gestureRecognizer.locationInView(self.myMap)
            var newCoordinate = myMap.convertPoint(touchPoint, toCoordinateFromView: self.myMap)
            
            var loc = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            
            CLGeocoder().reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
                if((error) != nil) {
                    println("Error \(error)")
                } else {
                    let p = CLPlacemark(placemark: placemarks[0] as CLPlacemark)
                    var subThoroughfare:String
                    var thoroughfare:String
                    
                    if((p.subThoroughfare) != nil) {
                        subThoroughfare = p.subThoroughfare
                    } else {
                        subThoroughfare = ""
                    }
                    if((p.thoroughfare) != nil) {
                        thoroughfare = p.thoroughfare
                    } else {
                        thoroughfare = ""
                    }
                    
                    var title = "\(subThoroughfare) \(thoroughfare)"
                    
                    if title == " " {
                        var date = NSDate.date()
                        title = "Added \(date)"
                    }
                    
                    var annotation = MKPointAnnotation()
                    
                    annotation.coordinate = newCoordinate
                    annotation.title = title
                    self.myMap.addAnnotation(annotation)
                    
                    places.append(["name":title, "lat":"\(newCoordinate.latitude)", "lon":"\(newCoordinate.longitude)"])
                    
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "back" {
//            self.navigationController?.navigationBarHidden = false
//        }
//    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation = locations[0] as CLLocation
        
        var latitude:CLLocationDegrees = userLocation.coordinate.latitude
        var longitude:CLLocationDegrees = userLocation.coordinate.longitude
        
        var latDelta:CLLocationDegrees = 0.01
        var lonDelta:CLLocationDegrees = 0.01
        
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        manager.stopUpdatingLocation()
        
        myMap.setRegion(region, animated: true)
    }


}

