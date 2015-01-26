//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Clint on 1/9/15.
//  Copyright (c) 2015 Republic. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate {
    
    func addTask(message: String)
    func addTaskCanceled (message: String)
    
}

class AddTaskViewController: UIViewController {
    
    

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var delegate: AddTaskViewControllerDelegate?
    
    @IBAction func addTaskButtonTapped(sender: UIButton) {
        
//        var task = TaskModel(task: taskTextField.text, subTask: subtaskTextField.text, date: dueDatePicker.date, completed: false)
//        mainVC.baseArray[0].append(task)

        
        //creating a reference to our appdelegate class (appdelegate.swift)
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        //access managedObjectContext. managedObjectContext is an optional...
        let managedObjectContext = appDelegate.managedObjectContext
        
        //pull out our taskmodel entity, which is an optional
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        //create our task model instance here
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        //capitalize the text field
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
            task.task = taskTextField.text.capitalizedString
        
        } else {
            task.task = taskTextField.text
            
        }
        
        
        
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
            task.completed = true
        } else {
            task.completed = false
        }
        
        
        //this is the command to save things
        appDelegate.saveContext()
        
        //how do we get all the taskmodel instances into an array?
        //request all instances of taskmodel
        var request = NSFetchRequest(entityName: "TaskModel")
        var error: NSError? = nil
        
        //here is the array of results. the &error is a memory address where to put the error
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }

        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("task added")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTaskCanceled("task was not added")
        
    }
    
}
