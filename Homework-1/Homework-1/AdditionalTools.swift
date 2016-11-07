//
//  additionalTools.swift
//  GeekHubLessonOne
//
//  Created by konstantin on 10/25/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

struct operators {
    static let opAddition : Character = "+"
    static let opSubtraction : Character = "-"
    static let opMultiplication : Character = "*"
    static let opDivision : Character = "/"
}

public func isOperetionChar(ch: Character) -> Bool {
    if ch == operators.opAddition || ch == operators.opDivision
        || ch == operators.opMultiplication || ch == operators.opSubtraction {
        return true
    }
    return false
}


public func containsOperation(userInput: String) -> Bool {
    var firstChar: Bool = true
    for ch in userInput.characters {
        if firstChar {
            firstChar = false
        } else if isOperetionChar(ch) {
            return true
        }
    }
    return false
}