//
//  ProbabilityGenerator.swift
//  Task-4
//
//  Created by konstantin on 12/4/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class MagicBall {
    
    private static let maxChance = 101
    
    public static func isItPossible(chance: Int) -> Bool {
        
        return chance >= 0 && maxChance.getRandom() <= chance
        
    }
    
    public static func isItPossible(chances: Range<Int>) -> Bool {
        
        if chances.isEmpty || chances.minElement()! > chances.maxElement()! {
            return false
        }
        let eventProbability = maxChance.getRandom()
        
        return eventProbability >= chances.minElement()! && eventProbability <= chances.maxElement()!
        
    }
    
}