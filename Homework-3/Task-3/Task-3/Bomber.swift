//
//  Bomber.swift
//  Task-3
//
//  Created by konstantin on 11/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Bomber: Airplane {
        
    override init (initMark: String, initModel: String, initMaximumSpeed: Double, initMaximumHeigth: Double) {
        super.init(initMark: initMark, initModel: initModel, initMaximumSpeed: initMaximumSpeed, initMaximumHeigth: initMaximumHeigth)
    }
    
    override public func getAirplaneCost() -> Double {
        return super.getAirplaneCost() * 2
    }
}