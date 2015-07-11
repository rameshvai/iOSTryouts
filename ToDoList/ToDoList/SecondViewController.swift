//
//  SecondViewController.swift
//  ToDoList
//
//  Created by Ramesh Vaidyalingam on 10/5/14.
//  Copyright (c) 2014 Ramesh Vaidyalingam. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var todoItem: UITextField!
    
    @IBAction func addItem(sender: AnyObject) {
        toDoItems.append(todoItem.text)
        self.view.endEditing(true)
        
        let fixedToDoItems = toDoItems
        NSUserDefaults.standardUserDefaults().setObject(fixedToDoItems, forKey: "toDoItems")
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

