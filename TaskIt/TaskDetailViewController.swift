//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Clint on 1/6/15.
//  Copyright (c) 2015 Republic. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var subtaskTextField: UITextField!
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    var detailTaskModel: TaskModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println(self.detailTaskModel.task)
        
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subTask
        self.dueDatePicker.date = detailTaskModel.date
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
}
