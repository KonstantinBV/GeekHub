//
//  TaskManager.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public enum SortingType {
    
    case byText, byDate, byTaskID
    
}

public class TaskManager {
    
    //MARK: Members
    private static var selfInstance: TaskManager?
    
    //MARK: Properties
    
    private var tasks = [Task]()
    
    public static var instance: TaskManager {
        get {
            if selfInstance == nil {
                selfInstance = TaskManager()
            }
            return selfInstance!
        }
    }


    //MARK: Public Functions
    
    public func addTask(taskText: String) -> Task? {
        
        var newID = 0
        var newTask: Task? = nil
        if tasks.count > 0 {
            let sortedTasks = sortTasks(SortingType.byTaskID, withMain: false)
            newID = (sortedTasks.first?.taskID)! + 1
        }
        
        if !taskText.isEmpty {
            newTask = Task(taskID: newID, text: taskText)
            tasks.append(newTask!)
        }
        return newTask
    }
    
    public func removeTask(taskID: Int) {
        
        guard let index = tasks.indexOf( { $0.taskID == taskID } ) else {
            return
        }
        tasks.removeAtIndex(index)
        
    }
    
    public func sortTasks(sortingType: SortingType, withMain: Bool) -> [Task] {
        
        var sortedTasks = [Task]()
        switch sortingType {
            
            case SortingType.byDate:
                sortedTasks = tasks.sort ({ $0.0.date.isLessThanDate($0.1.date) })
            break
            case SortingType.byText:
                sortedTasks = tasks.sort ({ $0.0.text < $0.1.text })
            break
            case SortingType.byTaskID:
                sortedTasks = tasks.sort ({ $0.0.taskID < $0.1.taskID })
            break
            
        }
        
        if withMain {
            tasks = sortedTasks
        }
        
        return sortedTasks
    }
    
    public func getTasks() -> [Task] {
        
        return tasks
        
    }
    
}