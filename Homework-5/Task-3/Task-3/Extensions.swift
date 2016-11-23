//
//  StringExtended.swift
//  Task-1
//
//  Created by konstantin on 11/16/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public extension String {
    
    public func removeEverySecondCharacter() -> String {
        if self.isEmpty {
            return ""
        }
        return refillByValues("", step: 2)
    }
    
    public func replaceEveryThirdCharacter(char: Character) -> String {
        return refillByValues(String(char), step: 3)
    }
    
    public func refillByValues(inputValues: String, step: Int) -> String {
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
}

extension NSDate: Equatable {}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}
 /*
    public func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
    }
    
    public func isLessThanDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
    }
    
    public func equalToDate(dateToCompare: NSDate) -> Bool {
        
        return self.compare(dateToCompare) == NSComparisonResult.OrderedSame
    }
}*/

