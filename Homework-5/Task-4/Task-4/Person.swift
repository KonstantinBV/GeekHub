//
//  Person.swift
//  Task-4
//
//  Created by konstantin on 12/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public enum Country: UInt32 {
    
    case USA, Mexico
    
    static func randomCountry() -> Country {
        
        let rand = arc4random_uniform(2)
        return Country(rawValue: rand)!
        
    }
    
}

public enum Sex: UInt32 {
    
    case Male = 0, Female = 1
    
    static func randomSex() -> Sex {
        
        let rand = arc4random_uniform(2)
        return Sex(rawValue: rand)!
        
    }
    
}

public protocol Person {
    
    var name: String { get set }
    var surname: String { get set }    
    var birthday: NSDate { get set }
    var bornInTheCountry: Country? { get set }
    var sex: Sex? { get set }
    
    func getInfo() -> String
}