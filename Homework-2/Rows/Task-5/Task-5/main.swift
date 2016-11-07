//
//  main.swift
//  Task-5
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

print("Strings. Task # 5")
print("Please write the text:")
if let userInput: String = readLine() {
    var palindromes: [String] = []
    if let words: [String] = getWordsFromString(userInput) {
        for word in words {
            let reverseWord: String = String(word.characters.reverse())
            if word == reverseWord {
                palindromes.append(word)
            }
        }
    }
    if palindromes.isEmpty {
        print("There is no palindromes")
    } else {
        print("\(palindromes.count) palindromes found in the text:")
        print(palindromes.joinWithSeparator(", "))
    }
    
} else {
    print("Syntax error. There is no text for processing.")
}
