//
//  main.swift
//  Task-3
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

print("Strings. Task # 3")
print("Please write the text:")
var isResultPresent: Bool = false
var forceErrorMessage: Bool = true
if let userInput: String = readLine() {
    if let words: [String] = getWordsFromString(userInput) {
        var validWords: [String] = []
        for word in words {
            if let firstChar: Character = word.characters.first {
                if word.hasPrefix(String(firstChar)) && word.hasSuffix(String(firstChar)) && !validWords.contains(word) {
                    validWords.append(word)
                }
            }
        }
        if !validWords.isEmpty {
            isResultPresent = true
            let validWordsString = validWords.joinWithSeparator(", ")
            print("The count of words which have the same start and end character: \(validWords.count)")
            print("Words which have the same start and end character: \(validWordsString)")
        } else {
            forceErrorMessage = false
            print("Not found the words which have the same start and end character!")
        }
    }
}
if !isResultPresent && forceErrorMessage {
    print("Error.")
}


