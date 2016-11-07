//
//  main.swift
//  Task-1
//
//  Created by konstantin on 11/1/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

print("Arrays. Task # 1")
print("Please enter the numbers separated by space:")
if let userInput: String = readLine() {
    var positiveNumbers: [Double] = []
    var negativeNumbers: [Double] = []
    var zeroNumbersCount: Int = 0
    if let numbersStrings: [String] = userInput.componentsSeparatedByString(" ") {
        for numbersString in numbersStrings {
            if let number: Double = Parser.calculateFromString(numbersString) {
                if number > 0 {
                    positiveNumbers.append(number)
                } else if number < 0 {
                    negativeNumbers.append(number)
                } else if number == 0 {
                    zeroNumbersCount++
                }
            }
        }
    }
    if positiveNumbers.count > 0 {
        print("Positive numbers count: \(positiveNumbers.count)")
        print("Positive numbers: \(positiveNumbers)")
    }
    if negativeNumbers.count > 0 {
        print("Negative numbers count: \(negativeNumbers.count)")
        print("Negative numbers: \(negativeNumbers)")
    }
    if zeroNumbersCount > 0 {
        print("Zero numbers count: \(zeroNumbersCount)")
    }
} else {
    print("Syntax error. There is no text for processing.")
}

