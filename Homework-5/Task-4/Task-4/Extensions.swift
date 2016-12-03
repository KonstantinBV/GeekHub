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
        
        return self.count == 0 ? nil : self[Int(arc4random_uniform(UInt32(self.count - 1)))]
        
    }
    
    public func getRandomString() -> String {
        
        guard let result = self.getRandomItem() as? String  else {
            return ""
        }
        return result
        
    }
    
}

public extension NSDate {
    
    static func randomBetweenDates(range: Range<Int> = 1960...1990) -> NSDate {
        
        let today = NSDate()
        let min = range.startIndex
        let max = range.endIndex
        if min > max || min == max || min == 0 || max == 0 {
            return today
        }
        
        guard let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) else {
            print("Не обнаружен каледарь \"NSCalendarIdentifierGregorian\"")
            return today
        }
        
        let r1 = arc4random_uniform(UInt32(30))
        let r2 = arc4random_uniform(UInt32(23))
        let r3 = arc4random_uniform(UInt32(23))
        let r4 = arc4random_uniform(UInt32(23))
        let r5 = arc4random_uniform(UInt32(max - min)) + UInt32(min)
        let offsetComponents = NSDateComponents()
        offsetComponents.day = Int(r1)
        offsetComponents.hour = Int(r2)
        offsetComponents.year = Int(r5)
        offsetComponents.minute = Int(r3)
        offsetComponents.second = Int(r4)

        
        guard let rndDate1 = gregorian.dateFromComponents(offsetComponents) else {
            print("Ошибка получения произвольной даты!")
            return today
        }
        return rndDate1
        
    }
}