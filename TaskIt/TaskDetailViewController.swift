//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Clint on 1/6/15.
//  Copyright (c) 2015 Republic. All rights reserved.
//

import UIKit

@objc protocol TaskDetailViewControllerDelegate {
    
    optional func taskDetailEdited()
    
}

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var detailTaskModel: TaskModel!
    
    var delegate: TaskDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //println(self.detailTaskModel.task)
        
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        //we're going to update the task with our changes
        
//        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subtask = subtaskTextField.text
        detailTaskModel.date = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        //appDelegate.saveContext()
        ModelManager.instance.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        delegate?.taskDetailEdited!()
    }
    
}
