//
//  FileManipulator.swift
//  Task-2
//
//  Created by konstantin on 11/16/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class JSONManipulator {
    
    let jsonFileName = "json-file.json"
    let fileManager = NSFileManager.defaultManager()
    var jsonFilePath = ""
    
    init(){
        jsonFilePath = fileManager.currentDirectoryPath + "/" + jsonFileName
    }
    
    public func packToJSON(inputItems:[(collectionName: String, collection: [DataItem])]) -> NSData? {
        var objectsData = [String: [String: String]]()
        for inputItem in inputItems {
            objectsData[inputItem.collectionName] = [String: String]()
            for dataItem in inputItem.collection {
                objectsData[inputItem.collectionName]![dataItem.name] = dataItem.value
            }
        }
        return objectsData.isEmpty ? nil : convertObjectToJSONData(objectsData)
    }
    
   /* public func unpackJSON(jsonString: String) -> [(collectionName: String, collection: [DataItem])] {
        var result = [(collectionName: String, collection: [DataItem])]()
        if !jsonString.isEmpty {
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(jsonString!, options: .AllowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    readJSONObject(dictionary)
                }
            } catch {
                // Handle Error
            }
        }
        return result
    }*/
    
    public func writeFile(data: NSData) {
        if !fileManager.createFileAtPath(jsonFilePath, contents: data, attributes: nil) {
            print("error")
        }
    }
    
    public func readFile() -> String {
        do {
            return try String(contentsOfFile: jsonFilePath, encoding: NSUTF8StringEncoding)
        }
        catch {
             print("Read data error")
        }
        return ""
    }
    
    private func convertObjectToJSONData(data:AnyObject) -> NSData? {
        
        do {
            let newData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
            return newData
        }
        catch {
            print("Error writing data")
        }
        return nil
    }
    
}


