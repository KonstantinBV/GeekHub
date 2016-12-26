//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

//MARK: Enums

enum SortingType {
    
    case byText, byDate
    
}

class ToDoHelper {
    
    //MARK: Singleton
    
    static let instanse =  ToDoHelper()
    
    //MARK: Delegates
    
    private var delegateSelf: ToDoMessageDelegate?
    
    var delegate: ToDoMessageDelegate? {
        get {
            return delegateSelf
        }
        set {
            delegateSelf = newValue
            dataHelper.delegate = newValue
        }
    }
    
    //MARK: Properties
    
    private var toDoList = [ToDo]()
    private var dataHelper = ToDoDataHelper()
    
    //MARK: Init Functions
    
    private init() {}
        
    //MARK: Base operations
    
    func add(toDo: ToDo) {
        
        toDoList.append(toDo)
    }
    
    func remove(index: Int) {
        
        toDoList.removeAtIndex(index)
        
    }
    
    func updateAtIndex(index: Int, toDo: ToDo) {
        
        toDoList[index] = toDo
        
    }
    
    func sort(sortingType: SortingType, withMain: Bool) -> [ToDo] {
        
        var sortedList = [ToDo]()
        switch sortingType {
            
            case SortingType.byDate:
                sortedList = toDoList.sort ({ $0.0.date.isLessThanDate($0.1.date) })
            break
            case SortingType.byText:
                sortedList = toDoList.sort ({ $0.0.text < $0.1.text })
            break
        }
        
        if withMain {
            toDoList = sortedList
        }
        
        return sortedList
    }
    
    func getToDoList() -> [ToDo] {
        
        return toDoList
        
    }
    
    //MARK: Working with data helper
    
    func loadData() {
       
        toDoList = dataHelper.loadData()
        
    }
    
    func saveData() {
        
        dataHelper.saveData(toDoList)
        
    }
    
}