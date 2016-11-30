//
//  FileManipulator.swift
//  Task-2
//
//  Created by konstantin on 11/16/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class JSONManager {
    
    public static func getStringFromNSData(data: NSData?) -> String {
        if let str = String(data: data!, encoding: NSUTF8StringEncoding) {
            return str
        }
        return ""
    }
    
    public static func convertObjectToJSONData(data:AnyObject) -> NSData? {
        
        do {
            let newData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
            return newData
        }
        catch {
            print("Ошибка конвертации")
        }
        return nil
    }    
}