//
//  StringExtended.swift
//  Task-1
//
//  Created by konstantin on 11/16/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

//MARK: String extension

extension String {
    
    func removeEverySecondCharacter() -> String {
        if self.isEmpty {
            return ""
        }
        return refillByValues("", step: 2)
    }
    
    func replaceEveryThirdCharacter(char: Character) -> String {
        return refillByValues(String(char), step: 3)
    }
    
    func refillByValues(inputValues: String, step: Int) -> String {
        if step <= 0 {
            return self
        }
        var validCharacters: [String] = []
        for (charIndex, char) in self.characters.enumerate(){
            if !inputValues.isEmpty && self.isEmpty {
                return inputValues
            }
            validCharacters.append((charIndex+1)%step == 0 ? inputValues.isEmpty ? "" : inputValues : String(char))
        }
        return validCharacters.joinWithSeparator("")
    }
    
    func toDateTime() -> NSDate
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateFromString : NSDate = dateFormatter.dateFromString(self)!
        return dateFromString
    }
    
    func toBool() -> Bool {
        return NSString(string: self).boolValue
    }
}

//MARK: NSDate extension

extension NSDate {
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare) == NSComparisonResult.OrderedSame
    }
    
    func dateTimeToString() -> String {
        return dateStringWithFormat("yyyy-MM-dd hh:mm:ss")
    }
    
    func dateStringWithFormat(format: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
}