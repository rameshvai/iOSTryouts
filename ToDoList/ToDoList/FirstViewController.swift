//
//  FirstViewController.swift
//  ToDoList
//
//  Created by Ramesh Vaidyalingam on 10/5/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

var toDoItems : [String] = []

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var taskTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = toDoItems[indexPath.row]
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        taskTable.reloadData()
        if var storedToDoItems: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("toDoItems") {
            toDoItems = []
            for var i = 0; i < storedToDoItems.count; ++i {
                toDoItems.append(storedToDoItems[i] as NSString)
            }
            taskTable.reloadData()
        }
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            toDoItems.removeAtIndex(indexPath.row)
            let fixedToDoItems = toDoItems
            NSUserDefaults.standardUserDefaults().setObject(fixedToDoItems, forKey: "toDoItems")
            NSUserDefaults.standardUserDefaults().synchronize()
            taskTable.reloadData()
        }
    }
    
}

