//
//  Extensions.swift
//  Task-4
//
//  Created by konstantin on 12/3/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public extension NSArray {
    
    public func getRandomItem() -> AnyObject? {
        
        return self.count == 0 ? nil : self[(self.count - 1).getRandom()]
        
    }
    
    public func getRandomString() -> String {
        
        guard let result = self.getRandomItem() as? String  else {
            return ""
        }
        return result
        
    }
    
    public func getAnyNotEqual <BaseType : Equatable>(element: Any, baseTye: BaseType.Type) -> BaseType? {
        
        for item in self {
            guard
                let elementEquatable = element as? BaseType,
                let itemEquatable = item as? BaseType
                else { return nil }
            if elementEquatable != itemEquatable {
                return itemEquatable
            }
        }
        return nil
    }
    
    func equalAny<BaseType: Equatable>(lhs: Any, rhs: Any, baseType: BaseType.Type) -> Bool {
        guard
            let lhsEquatable = lhs as? BaseType,
            let rhsEquatable = rhs as? BaseType
            else { return false }
        return lhsEquatable == rhsEquatable
    }
    
}

public extension Int {
    
    func getRandom() -> Int {
        
        if self <= 0 {
            return 0
        }
        
        let randomValue = Int(arc4random_uniform(UInt32(self)))
        
        return randomValue //self <= 0 ? 0 : Int(arc4random_uniform(UInt32(self)))
    }
    
}

public extension Range {
    
    func getRandomInt() -> Int {
        
        guard let firstValue = self.first else {
            return 0
        }
        
        if firstValue is Int {
            let min = self.startIndex as! Int
            let max = self.endIndex as! Int
            
            if min < 0 || min > max || min == max {
                return 0
            }

            return Int(arc4random_uniform(UInt32(max - min)) + UInt32(min))
        }
        
        return 0
    }
}

public extension NSDate {
    
    static func randomBetweenDates(range: Range<Int> = 1960...1990) -> NSDate {
        
        let today = NSDate()
        let rangeRandomInt = range.getRandomInt()
        if rangeRandomInt == 0 {
            return today
        }
        
        guard let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) else {
            print("Каледарь \"NSCalendarIdentifierGregorian\" не обнаружен!")
            return today
        }
        
        let offsetComponents = NSDateComponents()
        offsetComponents.day = 25.getRandom()
        offsetComponents.hour = 23.getRandom()
        offsetComponents.year = rangeRandomInt
        offsetComponents.minute = 23.getRandom()
        offsetComponents.second = 23.getRandom()
        
        guard let rndDate1 = gregorian.dateFromComponents(offsetComponents) else {
            print("Ошибка получения произвольной даты!")
            return today
        }
        return rndDate1
        
    }
}