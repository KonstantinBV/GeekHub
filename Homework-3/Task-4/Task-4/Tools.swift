//
//  Tools.swift
//  Task-4
//
//  Created by konstantin on 11/7/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Tools {
    
    init() {
    }
    
    public static func replace(_ text: String, _ target: String, _ withString: String) -> String {
        return text.isEmpty
            ? ""
            : text.stringByReplacingOccurrencesOfString(target,
                withString: withString)
    }
    
    func printActions(actions: [Int : String]) {
        print("")
        print("Выберите одну из доступных операций.")
        print("")
        let sortedActions = actions.sort { $0.0 < $1.0 }
        for (actionKey, actionMessage) in sortedActions {
            print("\(actionKey) - \(actionMessage)")
        }
    }
}