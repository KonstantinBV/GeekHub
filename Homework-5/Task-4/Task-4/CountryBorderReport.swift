//
//  CountryBorderReport.swift
//  Task-4
//
//  Created by konstantin on 12/4/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class CountryBorderReport {
    
    private var personsGenerator: PersonsGenerator
    
    init(_ personsGenerator: PersonsGenerator) {
        self.personsGenerator = personsGenerator
    }
    
    public func showStatictics() {
        
        var criminalsCount = 0
        
        print("Формирование статистики...")
        if personsGenerator.isEmpty {
            print("Ошибка. Отсутсвуют данные.")
            return
        }
        
        showCitizensStatistic(&criminalsCount)
        if criminalsCount > 0 {
            showFrontierGuardsStatistic(criminalsCount)
        }
        
    }
    
    private func showCitizensStatistic(inout criminalsCount: Int) {
        
        print("Старт подсчет статистики по гражданам...")
        var americansCrossedTheBorder = 0
        var mexicansCrossedTheBorder = 0
        var usaCriminalsCrossedTheBorder = 0
        var mexicoCriminalsCrossedTheBorder = 0
        var usaCriminalsArrested = 0
        var mexicoCriminalsArrested = 0
        
        var citizens = [Citizen]()
        
        citizens += personsGenerator.getAmericans()
        citizens += personsGenerator.getMexicans()
        
        for citizen in citizens {
            
            switch citizen.bornInTheCountry! {
                case Country.USA:
                    updateStatistics(citizen, crossedTheBorder: &americansCrossedTheBorder,
                        criminalCrossedTheBorder: &usaCriminalsCrossedTheBorder, criminalArrested: &usaCriminalsArrested)
                break
                case Country.Mexico:
                    updateStatistics(citizen, crossedTheBorder: &mexicansCrossedTheBorder,
                        criminalCrossedTheBorder: &mexicoCriminalsCrossedTheBorder, criminalArrested: &mexicoCriminalsArrested)
                break
            }
        }
        
        print("")
        print("Статистика по гражданам:")
        print("")
        
        let americansCount = personsGenerator.getAmericans().count
        let mexicansCount = personsGenerator.getMexicans().count
        let citizensCount = americansCount + mexicansCount
        let usaCriminals = usaCriminalsCrossedTheBorder + usaCriminalsArrested
        let mexicoCriminals = mexicoCriminalsCrossedTheBorder + mexicoCriminalsArrested
        let criminalsCrossedTheBorder = usaCriminalsCrossedTheBorder + mexicoCriminalsCrossedTheBorder
        let criminalsArrested = usaCriminalsArrested + mexicoCriminalsCrossedTheBorder
        criminalsCount = mexicoCriminals + usaCriminals
        
        print("Количество жителей США пересекших границу: \(americansCrossedTheBorder) - \(americansCrossedTheBorder * 100 / americansCount)%")
        print("Количество жителей Мексики пересекших границу: \(mexicansCrossedTheBorder) - \(mexicansCrossedTheBorder * 100 / mexicansCount)%")
        print("Из них количество преступников, которым удалось персечь границу: \(criminalsCrossedTheBorder) - \(criminalsCrossedTheBorder * 100 / citizensCount)% граждан")
        print("Количество арестованных преступников: \(criminalsArrested) - \(criminalsArrested * 100 / citizensCount)% граждан")
        print("Количество преступников США: \(usaCriminals) - \(usaCriminals * 100 / americansCount)% от всех граждан США")
        print("Количество преступников Мексики: \(mexicoCriminals) - \(mexicoCriminals * 100 / mexicansCount)% от всех граждан Мексики")
    }
    
    private func updateStatistics(citizen: Citizen, inout crossedTheBorder: Int,
        inout criminalCrossedTheBorder: Int, inout criminalArrested: Int) {
            
            if citizen.crossedTheBorder {
                crossedTheBorder += 1
                if citizen.isCriminal {
                    criminalCrossedTheBorder += 1
                }
            } else if citizen.arrested && citizen.isCriminal {
                criminalArrested += 1
            }
            
    }
    
    private func showFrontierGuardsStatistic(criminalsCount: Int) {
        
        print("")
        print("Статистика по пограничникам:")
        print("")
        
        for frontierGuard in personsGenerator.getFrontierGuards() {
            let arrestedCriminals = frontierGuard.getArrestedCriminalsCount()
            if arrestedCriminals > 0 {
                let arrestedPercentage = Double(arrestedCriminals) * Double(100) / Double(criminalsCount)
                print(frontierGuard.getInfoForReport() + " - " + arrestedPercentage.fixedFractionDigits(2) + "% от общего кол-ва преступников")
            } else {
                print("Пограничник \(frontierGuard.getName()) никого не задержал")
            }
            
        }
        
    }
    
}