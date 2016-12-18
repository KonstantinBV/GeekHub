//
//  TaskManager.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

enum SortingType {
    
    case byText, byDate
    
}

class TaskHelper {
    
    //MARK: Members
    private static var selfInstance: TaskHelper?
    
    //MARK: Properties
    
    private var tasks = [Task]()
    
    static var instance: TaskHelper {
        get {
            if selfInstance == nil {
                selfInstance = TaskHelper()
            }
            return selfInstance!
        }
    }


    //MARK: Public Functions
    
    func addTask(taskText: String) -> Task? {
        
        var newTask: Task?
        if !taskText.isEmpty {
            newTask = Task()
            newTask?.text = taskText
            tasks.append(newTask!)
        }
        return newTask
    }
    
    func addTask(newTask: Task) {
        
        tasks.append(newTask)
    }
    
    func removeTask(task: Task) {
        
        guard let index = tasks.indexOf( { $0.text == task.text && $0.date == task.date } ) else {
            return
        }
        tasks.removeAtIndex(index)
        
    }
    
    func sortTasks(sortingType: SortingType, withMain: Bool) -> [Task] {
        
        var sortedTasks = [Task]()
        switch sortingType {
            
            case SortingType.byDate:
                sortedTasks = tasks.sort ({ $0.0.date.isLessThanDate($0.1.date) })
            break
            case SortingType.byText:
                sortedTasks = tasks.sort ({ $0.0.text < $0.1.text })
            break
        }
        
        if withMain {
            tasks = sortedTasks
        }
        
        return sortedTasks
    }
    
    func getTasks() -> [Task] {
        
        return tasks
        
    }
}