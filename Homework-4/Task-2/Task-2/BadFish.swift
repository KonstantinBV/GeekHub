//
//  BadFish.swift
//  Task-2
//
//  Created by konstantin on 11/9/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class BadFish: Fish {
    
    public var fishWeigth: Int
    public var fishName: String
    public var eatenFishCount: Int
    
    init() {
        fishWeigth = 0
        eatenFishCount = 0
        fishName = ""
    }
    
    convenience init(fishWeigth: Int, fishName: String) {
        self.init()
        self.fishWeigth = fishWeigth
        self.fishName = fishName
    }
    
    public func eatingFish(fish: Fish) {
        fishWeigth += fish.fishWeigth
    }
}