//
//  FileManipulator.swift
//  Task-2
//
//  Created by konstantin on 11/16/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class FileManipulator {
    public func writeFile() {
        
    }
    
    public func readFile() {
        
    }
    
    public func packJSON() {
        
    }
    
    public func unpackJSON() {
        
    }
    
    public static func jsonToString(json: AnyObject){
        do {
            let data1 =  try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: NSUTF8StringEncoding) // the data will be converted to the string
            print(convertedString) // <-- here is ur string
            
        } catch let myJSONError {
            print(myJSONError)
        }        
    }
}


