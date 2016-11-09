//
//  BadFish.swift
//  Task-2
//
//  Created by konstantin on 11/9/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class FishPredator: Fish, Equatable {
    
    public var fishID: Int
    public var fishWeigth: Int
    public var fishName: String
    public var eatenFishesCount: Int
    
    init() {
        fishWeigth = 0
        eatenFishesCount = 0
        fishName = ""
        fishID = 0
    }
    
    convenience init(fishID: Int, fishWeigth: Int, fishName: String) {
        self.init()
        self.fishWeigth = fishWeigth
        self.fishName = fishName
        self.fishID = fishID
    }
    
    public func eatingFish(fish: Fish) {
        fishWeigth += fish.fishWeigth
        eatenFishesCount += 1
    }
    
    public func getInfo() -> String {
        return "Имя рыбы - \(fishName), вес рыбы - \(fishWeigth), съедено обычно рыбы - \(eatenFishesCount)"
    }
}

public func == (lhs: FishPredator, rhs: FishPredator) -> Bool {
    return lhs == rhs
}