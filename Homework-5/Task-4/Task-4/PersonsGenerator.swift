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
    
    init(americansCount: Int, mexicansCount: Int) {
        
        usaCitizensCount = americansCount
        mexicoCitizensCount = mexicansCount
        
    }
    
    public func generatePersons() {
        
        personNameGenerator.loadData()
        generateAmericans()
        generateMexicans()
        generateFrontierGuards()
        personNameGenerator.clearData()
        
    }
    
    private func generateAmericans() {
        
        repeat {
            
            let american = Citizen()
            american.bornInTheCountry = Country.USA
            american.birthday = NSDate.randomBetweenDates()
            american.sex = Sex.randomSex()
            personNameGenerator.setRandomName(american)
            
            usaCitizens.append(american)
            //print(american.getInfo())
        
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
            //print(mexican.getInfo())
            
        } while mexicoCitizens.count < mexicoCitizensCount
        
    }
    
    private func generateFrontierGuards() {
        /*print("================")
        print("Frontier guards")
        print("================")*/
        repeat {
            
            let frontierGuard = FrontierGuard()
            frontierGuard.bornInTheCountry = Country.randomCountry()
            frontierGuard.birthday = NSDate.randomBetweenDates()
            frontierGuard.sex = Sex.randomSex()
            personNameGenerator.setRandomName(frontierGuard)
            
            frontierGuards.append(frontierGuard)
            //print(frontierGuard.getInfo())
            
        } while frontierGuards.count < frontierGuardsCount
        
    }
    
}