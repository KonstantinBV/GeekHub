//
//  Border.swift
//  Task-4
//
//  Created by konstantin on 12/4/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Border {
       
    private var prison = [Citizen]()
    private var usa = [Citizen]()
    private var mexico = [Citizen]()
    private var frontierGuards = [FrontierGuard]()
    private var personsGenerator: PersonsGenerator?
    
    public func migrateCitizens() -> Bool {
        
       if !generatePersons() {
            return false
        }
        
        var americansTriedHisLuck = 0
        var mexicansTriedHisLuck = 0
        
        let americansCount = personsGenerator!.getAmericans().count
        let mexicansCount = personsGenerator!.getMexicans().count
        
        print("Старт процесса миграции. Пожалуйста подождите...")
        while true {
            switch Country.randomCountry() {
                case Country.USA:
                    if crossTheBorder(&usa, countryTo: &mexico) {
                        americansTriedHisLuck += 1
                    }
                break
            case Country.Mexico:
                if crossTheBorder(&mexico, countryTo: &usa) {
                    mexicansTriedHisLuck += 1
                }
                break
            }
            if americansTriedHisLuck == americansCount && mexicansTriedHisLuck == mexicansCount {
                    break
            }
        }
        print("Процесс миграции завершен.")
        return true
    }
    
    
    public func showStatistics() {
        
        guard let validGenerator = personsGenerator else {
            print("Ошибка формирования отчета. Генератор лиц не обнаружен.")
            return
        }
        
        let report = CountryBorderReport(validGenerator)
        report.showStatictics()
        
    }
    
    private func generatePersons() -> Bool {
        
        print("Введите количество граждан проживающих на территории США")
        guard let americansCount: Int = Int(readLine()!) else {
            print("Ошибка! Неверный формат данных.")
            return false
        }
        print("Введите количество граждан проживающих на территории Мексики")
        guard let mexicansCount: Int = Int(readLine()!) else {
            print("Ошибка! Неверный формат данных.")            
            return false
        }
        
        personsGenerator = PersonsGenerator(americansCount: americansCount, mexicansCount: mexicansCount)
        guard let validPersonsGenerator = personsGenerator else {
            return false
        }        
        
        validPersonsGenerator.generatePersons()
        
        if !validPersonsGenerator.isEmpty {
            usa = validPersonsGenerator.getAmericans()
            mexico = validPersonsGenerator.getMexicans()
            frontierGuards = validPersonsGenerator.getFrontierGuards()
        }
        
        return true
        
    }
    
    private func crossTheBorder(inout countryFrom:[Citizen], inout countryTo: [Citizen]) -> Bool {
        
        if countryFrom.count == 0 {
            return false
        }
        guard let migrantIndex = getMigrantIndex(countryFrom) else {
            return false
        }
        let citizen = countryFrom.removeAtIndex(migrantIndex)
        let frontierGuard = (frontierGuards as NSArray).getRandomItem() as! FrontierGuard
        if frontierGuard.checkCitizenOnCriminal(citizen) {
            citizen.arrested = true
            prison.append(citizen)
        } else {
            citizen.crossedTheBorder = true
            countryTo.append(citizen)
        }
        return true
        
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