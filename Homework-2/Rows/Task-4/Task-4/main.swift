//
//  main.swift
//  Task-4
//
//  Created by konstantin on 11/1/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

extension String
{
    private func replace(target: String, withString: String) -> String {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString)
    }
}


private func getWordsFromString (str: String) -> [String]? {
    if let result: [String] = str.replace(", ", withString: " ").replace(". ", withString: " ").componentsSeparatedByString(" ") {
        return result
    } else {
        return nil
    }
}

print("Strings. Task # 4")
print("Please write the text:")
var sumOfDigits: Int = 0
if let userIntup: String = readLine() {
    for ch in userIntup.characters {
        if let digitCharacter: Int = Int(String(ch)) {
            sumOfDigits += digitCharacter
        }
    }
} else{
    print("Syntax error. There is no text for processing.")
}
if sumOfDigits > 0 {
    print("The sum of the digits in the text: \(sumOfDigits)")
} else {
    print("The text dosn't contain digits.")
}
