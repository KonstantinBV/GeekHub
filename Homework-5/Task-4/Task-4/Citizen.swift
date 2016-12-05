//
//  Citizen.swift
//  Task-4
//
//  Created by konstantin on 12/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public enum CriminalOffense: UInt32 {
    
    case HasWeapon = 0, HasDrugs = 1, HasProhibitedItems = 2, Wanted = 3, CriminalPast = 4
    
    static func randomCriminalOffense() -> CriminalOffense {
       
        let range: Range<Int> = Range(Int(CriminalOffense.HasWeapon.rawValue)...Int(CriminalOffense.CriminalPast.rawValue))
        let rand = UInt32(range.getRandomInt())
        return CriminalOffense(rawValue: rand)!
        
    }
    
    func toString() -> String {
        
        switch self {
        case .HasWeapon:
            return "Имеет оружие"
        case .HasDrugs:
            return "Имеет наркотики"
        case .HasProhibitedItems:
            return "Имеет запрещенные предметы"
        case .Wanted:
            return "Находится в розыске"
        case .CriminalPast:
            return "Имеет криминальное прошлое"
        }
        
    }
    
}

public class Citizen: Person {
    
    private let criminalOffenseChances = Range(0...4)
    
    
    public var name: String = ""
    public var surname: String  =  ""
    public var birthday: NSDate = NSDate()
    public var bornInTheCountry: Country?
    public var sex: Sex?
    public var criminalOffense: CriminalOffense?
    public var isCriminal: Bool { return criminalOffense != nil }
    public var crossedTheBorder = false
    public var arrested = false
    
    init() {
        
        if MagicBall.isItPossible(criminalOffenseChances) {
            criminalOffense = CriminalOffense.randomCriminalOffense()
        }
        
    }
    
    public func getInfo() -> String {
        
        return "Имя: \(name) \(surname)\r\nДата рождения: \(birthday);" +
        "\r\nПол: \(sex!);\r\nСтрана: \(bornInTheCountry!);\r\nУголовное преступление: \(criminalOffense == nil ? "Отсутствует" : criminalOffense!.toString())"
        
    }
    
}