//
//  main.swift
//  Homework-1
//
//  Created by konstantin on 11/7/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

print("Lets start! Enter values:")
if let userInput : String = readLine() {
    if var result: Double = Parser.calculateFromString(userInput) {
        print("Result is: \(result)")
    } else {
        print("Error")
    }
}