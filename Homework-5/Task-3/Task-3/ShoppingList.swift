//
//  ShoppingList.swift
//  Task-3
//
//  Created by konstantin on 11/22/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class ShoppingList {
    
    public var purchases = [Purchase]()
    
    public func sortByDate() -> [Purchase] {
        return purchases.sort { $0.date < $1.date }
    }
    
    public func add(title: String) {
        if !title.isEmpty {
            add(Purchase(title: title))
        } else {
            print("Ошибка. Название не может быть пустым.")
        }
    }
    
    public func add(purchase: Purchase) {
        purchases.append(purchase)
    }
    
    public func remove() {
        
    }
    
    public func find(title: String) -> Purchase {
        return Purchase()
    }
    
    public func printSortedItems() {
        
    }
}