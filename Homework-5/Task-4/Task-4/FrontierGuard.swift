//
//  FrontierGuard.swift
//  Task-4
//
//  Created by konstantin on 12/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class FrontierGuard: Person {
    
    private static let minSkillLevel: Int = 10
    private static let maxSkillLevel: Int = 80
    
    private let skillChances = Range(minSkillLevel...maxSkillLevel)
    
    public var name: String = ""
    public var surname: String  =  ""
    public var birthday: NSDate = NSDate()
    public var bornInTheCountry: Country?
    public var sex: Sex?
    
    private var skill: Int = minSkillLevel
    private var arrestedCriminals = 0
    
    init() {
        
        skill = skillChances.getRandomInt()
        
    }
    
    public func checkCitizenOnCriminal(citizen: Citizen) -> Bool {
        
        if citizen.isCriminal && MagicBall.isItPossible(skill) {
            arrestedCriminals += 1
            return true
        }
        
        return false
        
    }
    
    public func getInfo() -> String {
        
        return "Имя: \(name) \(surname)\r\nДата рождения: \(birthday);" +
            "\r\nПол: \(sex!);\r\nСтрана: \(bornInTheCountry!);" +
            "\r\nНавык обыска: \(skill);\r\nЗадержано преступников: \(arrestedCriminals)"
        
    }
    
    public func getName() -> String {
        
        return "\(name) \(surname)"
        
    }
    
    public func getInfoForReport() -> String {
        
        return "Пограничником " + getName() + " задержано преступников: \(arrestedCriminals)"
        
    }
    
    public func getArrestedCriminalsCount() -> Int {
        
        return arrestedCriminals
        
    }
    
}