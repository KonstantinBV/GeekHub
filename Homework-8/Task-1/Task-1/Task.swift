//
//  Task.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public struct Task {
    
    //MARK: Properties
    
    private var taskID = 0
    public var text = ""
    public var date = NSDate()
    public var isDone = false
    
    public var isNew: Bool {
        get {
            return taskID == 0
        }
    }
    
    //MARK: Init functions
    
    init() {
        
    }
    
    init(text: String) {
        self.text = text
    }
    
    //MARK: Functions
    
    public mutating func setTaskID(taskID: Int) {
        self.taskID = taskID
    }
    
    public func getTaskID() -> Int {
        return taskID
    }
    
}