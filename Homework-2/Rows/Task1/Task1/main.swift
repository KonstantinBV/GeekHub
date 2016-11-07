//
//  main.swift
//  Task1
//
//  Created by konstantin.
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

print("Strings. Task # 1")
print("Show shortest and longest words")
print("Please write the text:")
var isResultPresent: Bool = false
if let userInput : String = readLine() {
    if let words: [String] = getWordsFromString(userInput) {
        if words.count < 2 {
            print("Syntax error. You must write minimum two words.")
        } else {
            var sortedArray = words.sort{ $0.characters.count > $1.characters.count}
            if !sortedArray.isEmpty {
                var longestWords: [String] = [sortedArray[0]]
                var shortestWords: [String] = [sortedArray[sortedArray.count - 1]]
                isResultPresent = true
                if longestWords[0].characters.count != shortestWords[0].characters.count {
                    for wordIndex in 1..<sortedArray.count {
                        var currentWord = sortedArray[wordIndex]
                        if !longestWords.contains(currentWord) && currentWord.characters.count == longestWords[0].characters.count  {
                            longestWords.append(currentWord)
                        }
                        if !shortestWords.contains(currentWord) && currentWord.characters.count == shortestWords[0].characters.count {
                            shortestWords.append(currentWord)
                        }
                    }
                    
                    var s = sortedArray.joinWithSeparator(", ")
                    print("Longest word\(longestWords.count > 1 ? "s:" : " is") '\(longestWords.joinWithSeparator(", "))'")
                    print("Characters count: \(longestWords[0].characters.count)")
                    print("")
                    print("Shortest word\(shortestWords.count > 1 ? "s:" : " is") '\(shortestWords.joinWithSeparator(", "))'")
                    print("Characters count: \(shortestWords[0].characters.count)")
                } else {
                    print("Your text contains only words with \(longestWords[0].characters.count) characters")
                }
            }
        }
    }
}
    
if !isResultPresent {
    print("Syntax error!")
}