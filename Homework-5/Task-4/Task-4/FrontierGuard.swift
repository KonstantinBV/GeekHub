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
    
    private let skillRange: Range<Int> = Range(minSkillLevel...maxSkillLevel)
    
    public var name: String = ""
    public var surname: String  =  ""
    public var birthday: NSDate = NSDate()
    public var bornInTheCountry: Country?
    public var sex: Sex?
    
    private var skill: Int = minSkillLevel
    private var arrestedCriminals = 0
    
    init() {
        
        skill = skillRange.getRandomInt()
        
    }
    
    public func citizenIsCriminal(citizen: Citizen) -> Bool {
        
        if citizen.lawAbiding {
            return false
        }
        
        if ProbabilityGenerator.isItPossible(skill) {
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
    
}