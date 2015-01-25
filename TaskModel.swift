//
//  TaskModel.swift
//  TaskIt
//
//  Created by Clint on 1/11/15.
//  Copyright (c) 2015 Republic. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
