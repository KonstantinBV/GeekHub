//
//  Calculator.swift
//  Task-1
//
//  Created by konstantin on 12/11/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Calculator {
    
    //MARK: Structs
    
    private struct Manipulator {
        var input = ""
        var firstNumber = 0.0
        var operand: validOperations?
        var secondNumber = 0.0
        var isEmpty: Bool { return input.isEmpty && firstNumber == 0 && operand == nil && secondNumber == 0 }
    }
    
    //MARK: Enums
    
    private enum validOperations: String {
        
        case sum = "+", subtraction = "-",
        multiplication = "✕", division = "÷", percentage = "%"
        
    }
    
    //MARK: Properties
    
    private var manipulator = Manipulator()
    
    //MARK: Public Functions
    
    public func getResult() -> Double {
        
        if manipulator.isEmpty || (manipulator.input.isEmpty && manipulator.firstNumber == 0) {
            return 0
        } else if manipulator.operand == nil && manipulator.firstNumber != 0 {
            return manipulator.firstNumber
        } else if !manipulator.input.isEmpty && manipulator.secondNumber == 0 {
            manipulator.secondNumber = Double(manipulator.input)!
        } else if manipulator.operand != nil && manipulator.secondNumber == 0 {
            return manipulator.firstNumber
        }
        
        var result:Double = 0
        switch manipulator.operand! {
            case validOperations.sum:
                result = calculate{$0 + $1}
            case validOperations.subtraction:
                result = calculate{$0 - $1}
            case validOperations.multiplication:
                result = calculate{$0 * $1}
            case validOperations.division:
                result = calculate{$0 / $1}
            case validOperations.percentage:
                if manipulator.firstNumber == 0 {
                    result = Double(manipulator.input)! / 100.0
                } else {
                    manipulator.secondNumber = manipulator.firstNumber * Double(manipulator.input)! / 100
                    result = Double(manipulator.input)!
                }
        }
        manipulator.input = "\(result)"
        return result
        
    }
    
    public func getDisplayText(input: String) -> Double {
        
        guard let _ = Double(input) else {
            if manipulator.input.isEmpty {
                return 0
            }
            switch input {
            case validOperations.sum.rawValue:
                manipulator.operand = validOperations.sum
            case validOperations.subtraction.rawValue:
                manipulator.operand = validOperations.subtraction
            case validOperations.multiplication.rawValue:
                manipulator.operand = validOperations.multiplication
            case validOperations.division.rawValue:
                manipulator.operand = validOperations.division
            case validOperations.percentage.rawValue:
                manipulator.operand = validOperations.percentage
            default: break
            }
            if manipulator.firstNumber == 0 {
                manipulator.firstNumber = Double(manipulator.input)!
                manipulator.input = ""
            }

            return manipulator.firstNumber
        }
        
        manipulator.input += input
        return  Double(manipulator.input)!
    }
    
    public func clear() {
        
        manipulator = Manipulator()
        
    }
    
    //MARK: Private Functions
    
    private func calculate(operation: (Double, Double) -> Double) -> Double {
        let result = operation(manipulator.firstNumber, manipulator.secondNumber)
        clear()
        manipulator.input = "\(result)"
        return result
    }
}