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
        
        let minIndex = CriminalOffense.HasWeapon.rawValue
        let maxIndex = CriminalOffense.CriminalPast.rawValue
        
        let rand = arc4random_uniform(UInt32(maxIndex - minIndex)) + UInt32(minIndex)
        return CriminalOffense(rawValue: rand)!
        
    }
    
}

public class Citizen: Person {
    
    public var name: String = ""
    public var surname: String  =  ""
    public var birthday: NSDate = NSDate()
    public var bornInTheCountry: Country?
    public var sex: Sex?
    public var criminalOffense: CriminalOffense?
    public var lawAbiding: Bool { return criminalOffense == nil }
    public var crossedTheBorder = false
    
    public func getInfo() -> String {
        
        return "Name: \(name) \(surname)\r\nBirthday: \(birthday);\r\nSex: \(sex!);\r\nCountry: \(bornInTheCountry!) \r\n"
        
    }
    
}