//
//  MasterViewController.swift
//  BlogReader
//
//  Created by Ramesh Vaidyalingam on 10/11/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit
import CoreData

var activeItem:String = ""

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var appDel : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        var context : NSManagedObjectContext = appDel.managedObjectContext!
        
        let urlPath = "https://www.googleapis.com/blogger/v3/blogs/10861780/posts?key=AIzaSyAkUwbSe87TCFlfWufc5K5wxN1Z4-DCy7Q"
        
        let url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if ((error) != nil) {
                println(error)
            } else {
                
                var request = NSFetchRequest(entityName: "BlogItems")
                request.returnsObjectsAsFaults = false
                var results : NSArray = context.executeFetchRequest(request, error: nil)!
                
                for result in results {
                    context.deleteObject(result as NSManagedObject)
                    context.save(nil)
                }
                
                let jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

                let items = jsonResult["items"] as NSArray
                
                var itemDict = [[String:String]()]
                
                var newBlogItem : NSManagedObject
                
                for var i = 0; i < items.count; ++i {
                    
                    var item:NSDictionary = items[i] as NSDictionary
                    
                    var authDict = item["author"] as NSDictionary
                    
                    itemDict.append([String:String]())
                    
                    itemDict[i]["author"] = authDict["displayName"] as NSString
                    itemDict[i]["content"] = item["content"] as NSString
                    itemDict[i]["title"] = item["title"] as NSString
                    itemDict[i]["publishedDate"] = item["published"] as NSString
                    
                    newBlogItem = NSEntityDescription.insertNewObjectForEntityForName("BlogItems", inManagedObjectContext: context) as NSManagedObject
                    
                    newBlogItem.setValue(itemDict[i]["author"], forKey: "author")
                    newBlogItem.setValue(itemDict[i]["title"], forKey: "title")
                    newBlogItem.setValue(itemDict[i]["content"], forKey: "content")
                    newBlogItem.setValue(itemDict[i]["publishedDate"], forKey: "publishedDate")
                    
                    context.save(nil)
                    
//                    var author:String = authDict["displayName"] as NSString
//                    var content:String = item["content"] as NSString
//                    var title:String = item["title"] as NSString
//                    var pubDate:String = item["published"] as NSString
//                    println("\(author) - \(title) - \(pubDate) - XXX\(i)XXX - \(content)")
                }
                
                request = NSFetchRequest(entityName: "BlogItems")
                request.returnsObjectsAsFaults = false
                results = context.executeFetchRequest(request, error: nil)!
//                println(results)
                
//                println(itemDict)
                
//                var item:NSDictionary = items[0] as NSDictionary
////                println(item)
//                var authDict = item["author"] as NSDictionary
//                var author:String = authDict["displayName"] as NSString
//                var content:String = item["content"] as NSString
//                var title:String = item["title"] as NSString
//                var pubDate:String = item["published"] as NSString
//                
//                println("\(author) - \(title) - \(pubDate) - \(content) - \(items.count)")
            }
        })
        
        task.resume()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name, inManagedObjectContext: context) as NSManagedObject
             
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        newManagedObject.setValue(NSDate.date(), forKey: "timeStamp")
             
        // Save the context.
        var error: NSError? = nil
        if !context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //println("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let object = self.fetchedResultsController.objectAtIndexPath(indexPath!) as NSManagedObject

            activeItem = object.valueForKey("content")!.description

            let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController

            controller.detailItem = object
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let s : NSArray = self.fetchedResultsController.sections!
        return s.count
//        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let s : NSArray = self.fetchedResultsController.sections!
        return s[section].numberOfObjects
//        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
//        cell.textLabel?.text = "Blog Item"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject)
                
            var error: NSError? = nil
            if !context.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //println("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
        cell.textLabel?.text = object.valueForKey("title")!.description
        cell.detailTextLabel?.text = object.valueForKey("author")!.description
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("BlogItems", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "publishedDate", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
    	var error: NSError? = nil
    	if !_fetchedResultsController!.performFetch(&error) {
    	     // Replace this implementation with code to handle the error appropriately.
    	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //println("Unresolved error \(error), \(error.userInfo)")
    	     abort()
    	}
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath)!, atIndexPath: indexPath)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

