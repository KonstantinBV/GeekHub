//
//  main.swift
//  Task-2
//
//  Created by konstantin on 11/1/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

print("Arrays. Task # 2")
print("Please enter the numbers separated by space:")
if let userInput: String = readLine() {
    var largestElement: Double = 0
    var smallestElement: Double = 0
    if let numbersStrings: [String] = userInput.componentsSeparatedByString(" ") {
        var numbers: [Double] = []
        for numbersString in numbersStrings {
            if let number: Double = Parser.calculateFromString(numbersString) {
                numbers.append(number)
            }
        }
        if numbers.count > 0 {
            var sortedNumbers = numbers.sort { $0 < $1 }
            let minValue = sortedNumbers[0]
            let maxValue = sortedNumbers[sortedNumbers.count - 1]
            for (index, value) in numbers.enumerated() {
                var currentItem = numbers[index]
                if currentItem == minValue {
                    numbers[index] = maxValue
                } else if currentItem == maxValue {
                    numbers[index] = minValue
                }
            }
            print("Result: \(numbers)")
        } else {
            print("Your text dosn't contains numbers!")
        }
    }
} else {
    print("Syntax error. There is no text for processing.")
}
