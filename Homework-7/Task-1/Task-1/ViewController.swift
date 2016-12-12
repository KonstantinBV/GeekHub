//
//  ViewController.swift
//  Task-1
//
//  Created by konstantin on 12/11/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Enums
    
    private enum Operations: String {
        
        case plus = "+", minus = "-",
        multiplication = "×", division = "÷", percentage = "%"
        
        private static let allValues = [plus, minus, multiplication, division, percentage]
        
        static func isOperation(input: String) -> Bool {
            
            for enumVal in allValues {
                if enumVal.rawValue == input {
                    return true
                }
            }
            return false
        }

    }

    //MARK: Properties
    
    @IBOutlet weak var displayTextLabel: UILabel!
   
    
    private var displayValue: Double {
        get {
            return Double(displayTextLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            var valueArray = value.componentsSeparatedByString(".")
            if valueArray.count == 2 && valueArray[1] == "0" {
                displayTextLabel.text = valueArray[0]
            } else {
                displayTextLabel.text = value
            }
            if !isPlusMinusPressed {
                isTyping = false
            } else {
                isPlusMinusPressed = false
            }
        }
    }
    
    private var firstValue = 0.0
    private var secondValue = 0.0
    private var onOperationsPressedCount = 0
    private var operation = ""
    
    private var isTyping = false
    private var decimalIsPressed = false
    private var isPlusMinusPressed = false
    
    //MARK: Actions

    
    @IBAction func onDigitPressed(sender: UIButton) {
        
        if displayTextLabel.text?.characters.count > 20 {
            return
        }
        
        let digit = sender.currentTitle!
        if isTyping {
            displayTextLabel.text = displayTextLabel.text! + digit
        } else {
            displayTextLabel.text = digit
            isTyping = true
        }
        
    }
    
    @IBAction func onOperationPressed(sender: UIButton) {
        
        let operation = sender.currentTitle!
        if operation == Operations.percentage.rawValue {
            if firstValue == 0 {
                displayValue = 0
            } else {
                displayValue = firstValue * displayValue / 100
                firstValue = 0
            }
        } else {
            /*onOperationsPressedCount += 1
            if isTyping && onOperationsPressedCount == 1 {
                onResultPressed()
            }*/
            onResultPressed()
            firstValue = displayValue
            self.operation = operation
        }
        isTyping = false
        decimalIsPressed = false
        
    }
    
    @IBAction func onPlusMinusPressed(sender: UIButton) {
        
        if displayValue != 0 {
            isPlusMinusPressed = true
            displayValue = -displayValue
        }
        
    }
    
    @IBAction func onDecimalPressed(sender: UIButton) {
        
        if isTyping && !decimalIsPressed {
            displayTextLabel.text = displayTextLabel.text! + "."
            decimalIsPressed = true
        } else if !isTyping && !decimalIsPressed {
            displayTextLabel.text = "0."
        }
        
    }

    
    @IBAction func onClearClick(sender: UIButton) {
        
        isPlusMinusPressed = false
        
        firstValue = 0
        secondValue = 0
        operation = ""
        decimalIsPressed = false
        displayValue = 0
        onOperationsPressedCount = 0
        
    }
    
    @IBAction func onResultPressed() {
        
        if isTyping {
            secondValue = displayValue
            onOperationsPressedCount = 0
        }
        
        decimalIsPressed = false
        isPlusMinusPressed = false
        
        switch operation {
        case Operations.plus.rawValue:
            calculate("+")
        case Operations.minus.rawValue:
            calculate("-")
        case Operations.multiplication.rawValue:
            calculate("*")
        case Operations.division.rawValue:
            calculate("/")
        default: break
        }
    }
    
    //MARK: Private Functions
    
    private func calculate(operationSign: String) {
        
        let numericExpression = "\(firstValue)\(operationSign)\(secondValue)"
        let expression = NSExpression(format: numericExpression)
        displayValue = expression.expressionValueWithObject(nil, context: nil) as! Double
        
    }
}