//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Ramesh Vaidyalingam on 10/10/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        
//        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
//        
//        newUser.setValue("Anantiga", forKey: "username")
//        newUser.setValue("passA", forKey: "password")
//        
//        context.save(nil)
        
        var request = NSFetchRequest(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "username = %@", "Ram")
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
        
        if (results.count > 0) {
            for result in results  {
//                result.setValue("password", forKey: "password")
                println(result)
            }
//            context.save(nil)
        } else {
            println("No results")
        }

//        if (results.count > 0) {
//            for result in results  {
//                context.deleteObject(result as NSManagedObject)
//                println("Item removed");
//            }
//            context.save(nil)
//        } else {
//            println("No results")
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

