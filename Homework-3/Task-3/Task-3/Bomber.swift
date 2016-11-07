//
//  Bomber.swift
//  Task-3
//
//  Created by konstantin on 11/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Bomber: Airplane {
        
    override init (_ initMark: String, _ initModel: String, _ initMaximumSpeed: Double, _ initMaximumHeigth: Double) {
        super.init(initMark, initModel, initMaximumSpeed, initMaximumHeigth)
    }
    
    override public func getAirplaneCost() -> Double {
        return super.getAirplaneCost() * 2
    }
}