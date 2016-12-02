//
//  Person.swift
//  Task-4
//
//  Created by konstantin on 12/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public enum Country {
    case USA, Mexico
}

public enum Sex {
    case Male, Female
}

public protocol Person {
    
    var name: String { get set }
    var surname: String { get set }    
    var birthday: NSDate { get set }
    var bornInTheCountry: Country? { get set }
    var sex: Sex? { get set }
    
    func getInfo() -> String
}