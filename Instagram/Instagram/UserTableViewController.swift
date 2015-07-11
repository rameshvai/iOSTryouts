//
//  UserTableViewController.swift
//  Instagram
//
//  Created by Ramesh Vaidyalingam on 11/9/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var users : [String] = []
    var following : [Bool] = []
    
    var refresher : UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        println(PFUser.currentUser())
        // Do any additional setup after loading the view, typically from a nib.

        updateUsers()

        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
    }
    
    func updateUsers() {
        var query = PFUser.query()
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            self.users.removeAll(keepCapacity: true)
            self.following.removeAll(keepCapacity: true)
            
            for object in objects {
                var user : PFUser = object as PFUser
                var isFollowing = false
                
                if user.username != PFUser.currentUser().username {
                    self.users.append(user.username)
                    
                    var query = PFQuery(className:"followers")
                    query.whereKey("follower", equalTo: PFUser.currentUser().username)
                    query.whereKey("following", equalTo: user.username)
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]!, error: NSError!) -> Void in
                        if error == nil {
                            for object in objects {
                                isFollowing = true
                            }
                            self.following.append(isFollowing)
                            self.tableView.reloadData()
                        } else {
                            println(error)
                        }
                    }
                }
            }
        })
    }
    
    func refresh() {
        println("refreshed")
        updateUsers()
        refresher.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel?.text = users[indexPath.row]
        if following.count > indexPath.row {
            if following[indexPath.row] {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell : UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            var query = PFQuery(className:"followers")
            query.whereKey("follower", equalTo: PFUser.currentUser().username)
            query.whereKey("following", equalTo: cell.textLabel?.text)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    for object in objects {
                        object.delete()
                    }
                } else {
                    println(error)
                }
            }
            
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            var following = PFObject(className: "followers")
            following["following"] = cell.textLabel?.text
            following["follower"] = PFUser.currentUser().username
            following.save()
        }
    }
}
