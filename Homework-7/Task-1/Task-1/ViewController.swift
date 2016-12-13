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
    private var operation = ""
    
    private var isTyping = false
    private var decimalIsPressed = false
    private var isPlusMinusPressed = false
    private var onPercentagePressed = false
    
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
        onPercentagePressed = operation == Operations.percentage.rawValue
        if isTyping {
            onResultPressed()
        }
        firstValue = displayValue
        self.operation = operation
        
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
        onPercentagePressed = false
        displayValue = 0
    }
    
    @IBAction func onResultPressed() {
        
        if isTyping {
            secondValue = displayValue
        }
        
        decimalIsPressed = false
        isPlusMinusPressed = false
        
        switch operation {
        case Operations.plus.rawValue:
            calculate(Operations.plus.rawValue)
        case Operations.minus.rawValue:
            calculate(Operations.minus.rawValue)
        case Operations.multiplication.rawValue:
            calculate("*")
        case Operations.division.rawValue:
            calculate("/")
        default: break
        }
    }
    
    //MARK: Private Functions
    
    private func calculate(operationSign: String) {
        
        var numericExpression = "\(firstValue)\(operationSign)\(secondValue)"
        if onPercentagePressed {
            if firstValue == 0 {
                displayValue = 0
            } else {
                numericExpression = "\(numericExpression)/100"
            }
            onPercentagePressed = false
        }
        let expression = NSExpression(format: numericExpression)
        displayValue = expression.expressionValueWithObject(nil, context: nil) as! Double
        
    }
}