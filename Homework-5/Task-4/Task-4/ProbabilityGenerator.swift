//
//  ProbabilityGenerator.swift
//  Task-4
//
//  Created by konstantin on 12/4/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class ProbabilityGenerator {
    
    private static let maxChance = 100
    
    public static func isItPossible(chance: Int) -> Bool {
        
        return chance > 0 && maxChance.getRandom() > chance
        
    }
    
}