//
//  Extensions.swift
//  Examination
//
//  Created by konstantin on 4/16/17.
//  Copyright © 2017 konstantin. All rights reserved.
//

import Foundation

extension String {
    
    func getID() -> Int {
    
        if self.isEmpty {
            print("Error! Strung is empty.")
            return Int.getInvalidID()
        }
        
        guard let validID = Int(self) else {
            print("Error! String doesn't have valid ID.")
            return Int.getInvalidID()
        }
        
        return validID
    }
}

extension Int {
    
    static func getInvalidID() -> Int {
        
        return -1
    }
    
    func isValidID() -> Bool {
        
        return self != Int.getInvalidID()
    }
    
}
