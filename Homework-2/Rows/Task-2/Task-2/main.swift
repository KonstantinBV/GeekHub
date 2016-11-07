//
//  main.swift
//  Task-2
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

print("Strings. Task # 2")
print("Calculate and show unique characters")
print("Please write the text:")
if let userInput : String = readLine() {
    var uniqueCharactersString: String = ""
    for ch in userInput.characters {
        if !uniqueCharactersString.characters.contains(ch) {
            uniqueCharactersString += String(ch)
        }
    }
    if uniqueCharactersString.characters.count > 0 {
        print("")
        print("Unique characters count: \(uniqueCharactersString.characters.count)")
        print("Unique characters: \(uniqueCharactersString)")
    } else {
        print("Syntax error!")
    }
}


