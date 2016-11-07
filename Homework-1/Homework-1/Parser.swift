//
//  parser.swift
//  GeekHubLessonOne
//
//  Created by konstantin on 10/25/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

class Parser {
    
    typealias tokenStr = (op: Character, token: String)
    typealias tokenVal = (op: Character, token: Double)
    
    private static func getTokens(exprString: String) -> [tokenStr]? {
        var newToken: String = ""
        var newOperation: Character = " "
        var tokens: [tokenStr] = []
        var firstParseChar: Bool = true
        var opMustFollow = false
        var opCannotFollow = true
        var bracketCount: Int = 0
        
        for exprChar in exprString.characters {
            if exprChar == " " {
                continue
            }
            
            if firstParseChar && (exprChar == operators.opAddition
                || exprChar == operators.opDivision) {
                    if exprChar == operators.opDivision {
                        tokens += [(op: " ", token: String(exprChar) + "1")]
                        newOperation = operators.opMultiplication
                    }
                    firstParseChar = false
                    continue
            }
            firstParseChar = false
            
            if !opMustFollow {
                if exprChar == "(" {
                    if bracketCount == 0 && !newToken.isEmpty {
                        return nil
                    }
                    bracketCount += 1
                    if bracketCount == 1 {
                        continue
                    }
                } else if exprChar == ")" {
                    if bracketCount == 0 {
                        return nil
                    }
                    bracketCount -= 1
                    if bracketCount == 0 {
                        opMustFollow = true
                        continue
                    }
                }
            }
            
            if bracketCount == 0 && isOperetionChar(exprChar) {
                if opCannotFollow || newToken.isEmpty {
                    return nil
                } else {
                    tokens += [(op: newOperation, token: newToken)]
                    newToken = ""
                    newOperation = exprChar
                    opMustFollow = false
                    opCannotFollow = true
                }
            } else {
                if opMustFollow {
                    return nil
                }
                newToken.append(exprChar)
                opCannotFollow = false
            }
        }
        
        tokens += [(op: newOperation, token: newToken)]
        if bracketCount > 0 {
            return nil
        } else {
            return tokens
        }
    }
    
    private static func calculate(userInput: String, rCount: Int = 0) -> Double? {
        
        if !containsOperation(userInput) {
            return Double(userInput)
        } else {
            let tokensToParse: [tokenStr]? = getTokens(userInput)
            if let tokens = tokensToParse {
                var valuesToProcess: [tokenVal] = []
                for token in tokens {
                    if let val = self.calculate(token.token, rCount: rCount+1) {
                        valuesToProcess += [(op: token.op, token: val)]
                    } else {
                        return nil
                    }
                }
                if valuesToProcess.isEmpty {
                    return nil
                }
                let firstToken = valuesToProcess[0]
                if firstToken.op != " " {
                    return nil
                }
                
                var i: Int = 1
                while i < valuesToProcess.count {
                    let op = valuesToProcess[i].op
                    let leftNum: Double = valuesToProcess[i-1].token
                    let rightNum: Double = valuesToProcess[i].token
                    
                    if op == operators.opMultiplication {
                        valuesToProcess[i-1].token = leftNum * rightNum
                        valuesToProcess.removeAtIndex(i)
                    } else if op == operators.opDivision {
                        valuesToProcess[i-1].token = leftNum / rightNum
                        valuesToProcess.removeAtIndex(i)
                    } else {
                        i += 1
                    }
                }
                
                var result: Double = valuesToProcess[0].token
                for i in 1..<valuesToProcess.count {
                    let token = valuesToProcess[i]
                    let num: Double = token.token
                    if token.op == operators.opAddition {
                        result = result + num
                    } else if token.op == operators.opSubtraction {
                        result = result - num
                    }
                }
                return result
            } else {
                return nil
            }
        }
    }
    
    static func calculateFromString(userInput: String) -> Double? {
        
        return Parser.calculate(userInput)
    }
}