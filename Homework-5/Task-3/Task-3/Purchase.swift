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
    private var date: NSDate = NSDate()
    private var checked: Bool = false
    
    init() {}
    
    init(_ title: String) {
        setTitle(title)
    }
    
    public func setTitle(title: String) {
        self.title = title
    }
    
    public func setChecked(checked: Bool) {
        self.checked = checked
    }
    
    public func setDate(date: NSDate) {
        self.date = date
    }
    
    public func getTitle() -> String {
        return title
    }
    
    public func getDate() -> NSDate {
        return date
    }
    
    public func getChecked() -> Bool {
        return checked
    }
    
    public func getCheckedInfo() -> String {
        return checked ? "выполнено" : "не выполнено"
    }
    
    public func getInfo() -> String {
        return "Название: \(title), дата: \(date.dateTimeToString()), отметка о выполнении: \(getCheckedInfo())"
    }
    
}