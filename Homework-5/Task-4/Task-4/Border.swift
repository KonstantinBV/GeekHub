//
//  Border.swift
//  Task-4
//
//  Created by konstantin on 12/4/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Border {
    
    //public var personsGenerator: PersonsGenerator = PersonsGenerator(americansCount: 0, mexicansCount: 0)
    
    private var prison = [Citizen]()
    private var usa = [Citizen]()
    private var mexico = [Citizen]()
    private var frontierGuards = [FrontierGuard]()
    private var personsGenerator: PersonsGenerator = PersonsGenerator(americansCount: 0, mexicansCount: 0)
    
    public func migrateCitizens() -> Bool {
        
       if !generatePersons() {
            return false
        }        
        
        while true {
            switch Country.randomCountry() {
                case Country.USA:
                   crossTheBorder(&usa, countryTo: &mexico)
                break
            case Country.Mexico:
                crossTheBorder(&mexico, countryTo: &usa)
                break
            }
            if getMigrantIndex(usa) == nil && getMigrantIndex(mexico) == nil {
                break
            }
        }
        return true
    }
    
    
    public func showStatistics() {
        
        print("Количество граждан пересекших границу: \(usa.count + mexico.count)")
        
    }
    
    private func generatePersons() -> Bool {
        
        print("Введите количество граждан проживающих на территории США")
        guard let americansCount: Int = Int(readLine()!) else {
            print("Ошибка! Неверный формат данных.")
            return false
        }
        print("Введите количество граждан проживающих на територии Мексики")
        guard let mexicansCount: Int = Int(readLine()!) else {
            print("Ошибка! Неверный формат данных.")            
            return false
        }
        personsGenerator = PersonsGenerator(americansCount: americansCount, mexicansCount: mexicansCount)
        personsGenerator.generatePersons()
        
        if !personsGenerator.isEmpty {
            usa = personsGenerator.getAmericans()
            mexico = personsGenerator.getMexicans()
            frontierGuards = personsGenerator.getFrontierGuards()
        }
        
        return true
        
    }
    
    private func crossTheBorder(inout countryFrom:[Citizen], inout countryTo: [Citizen]) {
        
        if countryFrom.count == 0 {
            return
        }
        
        while true {
            
            guard let migrantIndex = getMigrantIndex(countryFrom) else {
                break
            }
            
            let citizen = countryFrom.removeAtIndex(migrantIndex)
            
            let frontierGuard = (frontierGuards as NSArray).getRandomItem() as! FrontierGuard
            if frontierGuard.citizenIsCriminal(citizen) {
                citizen.arrested = true
                prison.append(citizen)
            } else {
                citizen.crossedTheBorder = true
                countryTo.append(citizen)
            }
        }
        
    }
    
    private func getMigrantIndex(citizens:[Citizen]) -> Int? {
        
        for (citizenIndex, citizen) in citizens.enumerate() {
            if !citizen.crossedTheBorder {
                return citizenIndex
            }
        }
        return nil
        
    }
    
}