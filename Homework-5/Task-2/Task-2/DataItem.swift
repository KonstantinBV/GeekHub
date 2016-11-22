//
//  Strings.swift
//  Task-2
//
//  Created by konstantin on 11/17/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class DataItem {
    public var name: String
    public var value: String
    
    init() {
        name = ""
        value = ""
    }
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}
