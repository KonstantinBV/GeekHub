//
//  ToDoDataHelper.swift
//  Task-1
//
//  Created by konstantin on 12/26/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

//MARK: JSON File Path

struct JSONFile {
    
    static let fileName = "ToDoData"
    
    static let fileExtension = "json"
    
    static var jsonFileName: String {
        get { return "\(fileName).\(fileExtension)" }
    }
    
}

class ToDoDataHelper {
    
    //MARK: Delegates
    
    var delegate: ToDoMessageDelegate?
    
    //MARK: Working with JSON
    
    private func convertToDoListToJSONData(toDoList: [ToDo]) -> NSData? {
        
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
            self.delegate?.showMessage("Attention", text: "Error while converting the data.")
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
                var toDo = ToDo()
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
        
        //return "/Users/Shared/\(JSONFile.jsonFileName)"
        
        guard let jsonFilePath = NSBundle.mainBundle().pathForResource(JSONFile.fileName, ofType: JSONFile.fileExtension) else {
            
            delegate?.showMessage("Error", text: "File '\(JSONFile.jsonFileName)' doesn't exist.")
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
            delegate?.showMessage("Attention", text: "Error while reading the file.")
        }
        return nil
    }
    
    //MARK: Data transactions
    
    func saveData(todoList: [ToDo]) {
        
        Utilities.doSomethingAssync { () -> () in
            
            guard let jsonData = self.convertToDoListToJSONData(todoList) else {
                return
            }
            
            guard let jsonFilePath = self.getJSONFilePath() else {
                return
            }
            
            let fileManager = NSFileManager.defaultManager()
            if !fileManager.createFileAtPath(jsonFilePath, contents: jsonData, attributes: nil) {
                self.delegate?.showMessage("Attention", text: "Error while saving data.")
            }
            
        }
        
    }
    
    func loadData() -> [ToDo] {
        
        guard let jsonObject = self.readJsonFile() else {
            return []
        }
        return parseJSONData(jsonObject)
        
    }
    
    
}