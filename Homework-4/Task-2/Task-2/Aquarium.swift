//
//  Aquarium.swift
//  Task-2
//
//  Created by konstantin on 11/9/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Aquarium {
    var simpleFishes: [Fish] = []
    var predatorFishes: [Fish] = []
    
    public func playWithAquarium() {
        print("Выберите одну из доступных операций:")
        print("1 - Выпустить рыбок и посмотреть что будет.")
        print("2 - Прекратить уничтожение рыбных запасов планеты.")
        if let userInput: String = readLine() {
            if userInput.isEmpty {
                print("Недопустимая операция")
                playWithAquarium()
            } else {
                switch userInput {
                    case "1":
                        fight()
                        playWithAquarium()
                    case "2":
                        return
                    default:
                        print("Недопустимая операция")
                        playWithAquarium()
                }
            }
        } else {
            print("Недопустимая операция")
            playWithAquarium()
        }
    }
    
    private func reinitAquarium() {
        var fishCounter = 0
        simpleFishes = []
        predatorFishes = []
        predatorFishes.append(FishPredator(fishID: fishCounter++, fishWeigth: 10, fishName: "Иваныч Кусаныч"))
        predatorFishes.append(FishPredator(fishID: fishCounter++,fishWeigth: 10, fishName: "Петровна Вырвижабровна"))
        let simpleFishesCount = Int(arc4random_uniform(UInt32(49)) + 10)
        while simpleFishes.count < simpleFishesCount {
            let fishWeigth =  Int(arc4random_uniform(UInt32(9)) + 1)
            simpleFishes.append(FishSimple(fishID: fishCounter++, fishWeigth: fishWeigth))
        }
    }
    
    private func fight () {
        reinitAquarium()
        var aquarium: [Fish] = simpleFishes
        aquarium += predatorFishes
       
        var predator: FishPredator?
        while aquarium.count > predatorFishes.count {
            if let fish: Fish = aquarium[Int(arc4random_uniform(UInt32(aquarium.count)))] {
                if fish is FishPredator && (predator == nil || fish.fishID != predator!.fishID) {
                    predator = fish as! FishPredator
                    continue
                }
                
                if fish is FishSimple && predator != nil {
                    predator!.eatingFish(fish)
                    let fishIndex: Int = aquarium.indexOf { $0.fishID == fish.fishID }!
                    aquarium.removeAtIndex(fishIndex)                    
                }
            }            
        }
        for fishPredator in predatorFishes {
            print((fishPredator as! FishPredator).getInfo())
        }
    }
}
