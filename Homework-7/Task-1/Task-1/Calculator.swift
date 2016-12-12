//
//  Calculator.swift
//  Task-1
//
//  Created by konstantin on 12/11/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public enum ValidOperations: String {
    
    case sum = "+", subtraction = "-",
    multiplication = "×", division = "÷", percentage = "%"
    
    private static let allValues = [sum, subtraction, multiplication, division, percentage]
    
    public static func isOperation(input: String) -> Bool {
        for enumVal in ValidOperations.allValues {
            if enumVal.rawValue == input {
                return true
            }
        }
        return false
    }
}

public class Calculator {
    
    //MARK: Structs
    
    private struct Manipulator {
        var input = ""
        var firstNumber = 0.0
        var operand: ValidOperations?
        var secondNumber = 0.0
        var isEmpty: Bool { return input.isEmpty && firstNumber == 0 && operand == nil && secondNumber == 0 }
    }
    
    //MARK: Properties
    
    private var manipulator = Manipulator()
    
    //MARK: Public Functions
    
    public func getResult(isEqualsPressed: Bool) -> Double {
        
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
            case ValidOperations.sum:
                result = calculate{$0 + $1}
            case ValidOperations.subtraction:
                result = calculate{$0 - $1}
            case ValidOperations.multiplication:
                result = calculate{$0 * $1}
            case ValidOperations.division:
                result = calculate{$0 / $1}
            case ValidOperations.percentage:
                if manipulator.firstNumber == 0 {
                    result = Double(manipulator.input)! / 100.0
                } else {
                    manipulator.secondNumber = manipulator.firstNumber * Double(manipulator.input)! / 100
                    result = Double(manipulator.input)!
                }
        }
        
        if isEqualsPressed {
            clear()
            manipulator.input = "\(result)"
        } else {
            manipulator.input = ""
            manipulator.firstNumber = result
            manipulator.secondNumber = 0
        }
        
        
        return result
        
    }
    
    public func getDisplayText(input: String) -> Double {
        
        guard let _ = Double(input) else {
            if manipulator.firstNumber == 0 && manipulator.input.isEmpty {
                return 0
            }
            switch input {
            case ValidOperations.sum.rawValue:
                manipulator.operand = ValidOperations.sum
            case ValidOperations.subtraction.rawValue:
                manipulator.operand = ValidOperations.subtraction
            case ValidOperations.multiplication.rawValue:
                manipulator.operand = ValidOperations.multiplication
            case ValidOperations.division.rawValue:
                manipulator.operand = ValidOperations.division
            case ValidOperations.percentage.rawValue:
                manipulator.operand = ValidOperations.percentage
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
        
        return operation(manipulator.firstNumber, manipulator.secondNumber)
        
    }
}