//
//  PersonsGenerator.swift
//  Task-4
//
//  Created by konstantin on 12/3/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class PersonsGenerator {
    
    private var usaCitizensCount = 0
    private var mexicoCitizensCount = 0
    private let frontierGuardsCount = 20
    
    private var personNameGenerator = PersonNameGenerator()
    
    private var usaCitizens = [Citizen]()
    private var mexicoCitizens = [Citizen]()
    private var frontierGuards = [FrontierGuard]()
    
    public var isEmpty: Bool { return usaCitizens.count == 0 || mexicoCitizens.count == 0 || frontierGuards.count == 0 }
    
    init(americansCount: Int, mexicansCount: Int) {
        
        usaCitizensCount = americansCount
        mexicoCitizensCount = mexicansCount
        
    }
    
    public func generatePersons() {
        
        personNameGenerator.loadData()
        print("Старт процесса генерации данных. Пожалуйста подождите...")
        generateAmericans()
        generateMexicans()
        generateFrontierGuards()
        print("Процес генерации данных завершен.")
        personNameGenerator.clearData()
        
    }
    
    public func getAmericans() -> [Citizen] {
        
        return usaCitizens
        
    }
    
    public func getMexicans() -> [Citizen] {
        
        return mexicoCitizens
        
    }
    
    public func getFrontierGuards() -> [FrontierGuard] {
        
        return frontierGuards
        
    }
    
    private func generateAmericans() {
        
        repeat {
            
            let american = Citizen()
            american.bornInTheCountry = Country.USA
            american.birthday = NSDate.randomBetweenDates()
            american.sex = Sex.randomSex()
            personNameGenerator.setRandomName(american)
            usaCitizens.append(american)
        
        } while usaCitizens.count < usaCitizensCount
        
    }
    
    private func generateMexicans() {
        
        repeat {
            
            let mexican = Citizen()
            mexican.bornInTheCountry = Country.Mexico
            mexican.birthday = NSDate.randomBetweenDates()
            mexican.sex = Sex.randomSex()
            personNameGenerator.setRandomName(mexican)
            mexicoCitizens.append(mexican)
            
        } while mexicoCitizens.count < mexicoCitizensCount
        
    }
    
    private func generateFrontierGuards() {
        
        repeat {
            
            let frontierGuard = FrontierGuard()
            frontierGuard.bornInTheCountry = Country.randomCountry()
            frontierGuard.birthday = NSDate.randomBetweenDates()
            frontierGuard.sex = Sex.randomSex()
            personNameGenerator.setRandomName(frontierGuard)
            frontierGuards.append(frontierGuard)
            
        } while frontierGuards.count < frontierGuardsCount
        
    }
    
}