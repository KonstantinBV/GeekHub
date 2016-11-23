//
//  Purchase.swift
//  Task-3
//
//  Created by konstantin on 11/22/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Purchase {
    
    private var title: String = ""
    public var date: NSData = NSData()
    private var checked: Bool = false
    
    init() {}
    
    init(title: String) {
        self.title = title
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public func getDate() -> NSData {
        return date
    }
    
    public func getChecked() -> Bool {
        return checked
    }
    
    public func setChecked(checked: Bool) {
        self.checked = checked
    }
    
}