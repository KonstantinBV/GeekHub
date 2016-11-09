//
//  GoodFish.swift
//  Task-2
//
//  Created by konstantin on 11/9/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class FishSimple: Fish, Equatable {
    
    public var fishWeigth: Int
    public var fishID: Int
    
    init(fishID: Int, fishWeigth: Int) {
        self.fishID = fishID
        self.fishWeigth = fishWeigth
    }
}

public func == (lhs: FishSimple, rhs: FishSimple) -> Bool {
    return lhs == rhs
}