//
//  Aquarium.swift
//  Task-2
//
//  Created by konstantin on 11/9/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Aquarium {
    var goodFishes: [Fish] = []
    var badFishes: [Fish] = []
    
    init() {
        initAquarium()
    }
    
    private func initAquarium() {
        badFishes.append(BadFish(fishWeigth: 10, fishName: "Garpo"))
        badFishes.append(BadFish(fishWeigth: 10, fishName: "Resty"))
        let goodFishCount = Int(arc4random_uniform(UInt32(49)) + 10)
        while goodFishes.count < goodFishCount {
            let fishWeigth =  Int(arc4random_uniform(UInt32(9)) + 1)
            goodFishes.append(GoodFish(fishWeigth: fishWeigth))
        }
    }
    
    public func fight () {
        var aquarium: [Fish] = goodFishes
        aquarium += badFishes
        while aquarium.count > 2 {
            let fish = aquarium[Int(arc4random_uniform(UInt32(aquarium.count-1)))]
            let otherFish = aquarium[Int(arc4random_uniform(UInt32(aquarium.count-1)))]
            if fish is BadFish && otherFish is GoodFish {
                (fish as! BadFish).eatingFish(otherFish)
                let index = aquarium.indexOf(otherFish as Fish)
                aquarium.removeAtIndex(index)
            } else if fish is GoodFish && otherFish is BadFish {
                
            }
        }
    }
}
