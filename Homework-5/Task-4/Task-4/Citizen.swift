//
//  Citizen.swift
//  Task-4
//
//  Created by konstantin on 12/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Citizen: Person {
    
    public var name: String = ""
    public var surname: String  =  ""
    public var birthday: NSDate = NSDate()
    public var bornInTheCountry: Country?
    public var sex: Sex?
    
    public func getInfo() -> String {
        return ""
    }
    
}