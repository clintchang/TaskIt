//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Clint on 1/23/15.
//  Copyright (c) 2015 Republic. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var capitilizeTableView: UITableView!

    @IBOutlet weak var completeNewTodoTableView: UITableView!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    let kVersionNumber = "1.0"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.capitilizeTableView.delegate = self
        self.capitilizeTableView.dataSource = self
        //dont want to allow scrolling because we're going to set the number of rows explicitly. going to have a fixed number of settings
        self.capitilizeTableView.scrollEnabled = false
        
        self.completeNewTodoTableView.delegate = self
        self.completeNewTodoTableView.dataSource = self
        self.completeNewTodoTableView.scrollEnabled = false
        
        self.title = "Settings"
        
        self.versionLabel.text = kVersionNumber
        
        //this is how you change the back button on a bar to something else
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonItemPressed:"))
        
        self.navigationItem.leftBarButtonItem = doneButton
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func doneBarButtonItemPressed (barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.capitilizeTableView {
            
            //for the uper 2 options
            var capitalizeCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as UITableViewCell
            
            if indexPath.row == 0 {
                capitalizeCell.textLabel?.text = "No do not capitalize"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == false {
                    //checkmark if we don't want to capitalize
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else {
                
                capitalizeCell.textLabel?.text = "Yes Capitalize!"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
            return capitalizeCell
            
        } else {
            
            
            //for the lower 2 options
            var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as UITableViewCell
            
            if indexPath.row == 0 {
                cell.textLabel?.text = "Do not complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == false {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            } else {
                cell.textLabel?.text = "Complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewTodoKey) == true {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }

            return cell
        }
        
    }
    
    //we want to hardcode this to 2 because we only want 2 rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    //sets height of each row
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    //set title of each section
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.capitilizeTableView {
            return "Capitalize new Task?"
            
        } else {
            return "Complete new Task?"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.capitilizeTableView {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
            } else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeTaskKey)
            }
        } else {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCompleteNewTodoKey)
            } else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCompleteNewTodoKey)
            }
        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
        
    }
}
