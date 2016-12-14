//
//  Task.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Task {
    
    //MARK: Properties
    
    public var taskID = 0
    public var text = ""
    public var date = NSDate()
    public var isDone = false
    
    //MARK: Init functions
    init() {
        
    }
    
    init(taskID: Int, text: String) {
        self.taskID = taskID
        self.text = text
    }
    
}