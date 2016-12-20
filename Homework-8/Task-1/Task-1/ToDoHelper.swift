//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

//MARK: Enums

enum SortingType {
    
    case byText, byDate
    
}

//MARK: ToDoHelper - extension

extension ToDoHelper {
    
    //MARK: Working with JSON
    
    private func convertToDoListToJSONData() -> NSData? {
        
        var result = [Dictionary<String, String>]()
        for toDo in toDoList {
            let mirror = Mirror(reflecting: toDo)
            var childrens = [(label: String?, value: Any)]()
            if let coll = AnyRandomAccessCollection(mirror.children) {
                childrens += coll
            }
            
            var childrensDict = Dictionary<String, String>()
            for children in childrens {
                childrensDict[children.label!] = children.value is NSDate
                    ? (children.value as! NSDate).dateTimeToString()
                    : String(children.value)
            }
            result.append(childrensDict)
        }
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(result, options: .PrettyPrinted)
            return jsonData
        }
        catch {
            print("Error while converting the data")
        }
        return nil
    }
    
    private func parseJSONData(jsonData: AnyObject) -> [ToDo] {
        
        var result = [ToDo]()
        
        if let jsonArray = jsonData as? NSArray {
            for arrayItem in jsonArray {
                guard let properties = arrayItem as? NSDictionary else {
                    continue
                }
                let toDo = ToDo()
                for property in properties {
                    if let key: String = String(property.key) {
                        if let value: String = String(property.value) {
                            switch key {
                            case "text":
                                toDo.text = value
                                break
                            case "date":
                                toDo.date = value.toDateTime()
                                break
                            case "isDone":
                                toDo.isDone = value.toBool()
                                break
                            default:
                                break
                            }
                        }
                    }
                }
                result.append(toDo)
            }
        }
        return result
        
    }
    
    //MARK: Working with files
    
    private func getJSONFilePath() -> String? {
        
        //return "/Users/konstantin/GeekHub/Homework-8/Task-1/Task-1/ToDoData.json"
        
        guard let jsonFilePath = NSBundle.mainBundle().pathForResource("ToDoData", ofType: "json") else {
            print("Error! File 'ToDoData.json' doesn't exist.")
            return nil
        }
        
        return jsonFilePath
        
    }
    
    private func readJsonFile() -> AnyObject? {
        
        guard let jsonFilePath = getJSONFilePath() else {
            return nil
        }
        
        do {
            let jsonString = try String(contentsOfFile: jsonFilePath, encoding: NSUTF8StringEncoding)
            let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            return try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
            
        } catch {
            print("Error while reading the file.")
        }
        return nil
    }
    
    //MARK: Data transactions
    
    func saveData() {
        
        guard let jsonData = convertToDoListToJSONData() else {
            return
        }
        
        guard let jsonFilePath = getJSONFilePath() else {
            return
        }
        
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.createFileAtPath(jsonFilePath, contents: jsonData, attributes: nil) {
            print("Error while saving data.")
        }
        
    }
    
    func loadData() {
        
        guard let jsonObject = readJsonFile() else {
            return
        }
        toDoList = parseJSONData(jsonObject)
        
    }
    
}

class ToDoHelper {
    
    //MARK: Properties
    
    private var toDoList = [ToDo]()
    
    //MARK: Base operations
    
    func add(toDo: ToDo) {
        
        toDoList.append(toDo)
    }
    
    func remove(index: Int) {
        
        toDoList.removeAtIndex(index)
        
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
    
}