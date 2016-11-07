//
//  Airplane.swift
//  Task-3
//
//  Created by konstantin on 11/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Airplane {
    
    public var mark: String = ""
    public var model: String = ""
    public var maximumSpeed: Double = 0
    public var maximumHeigth: Double = 0
    
    public func getAirplaneCost() -> Double {
        return maximumSpeed * 1000 + maximumHeigth * 100
    }
    
    public func getAirplaneInfo() -> String {
        return "Airplane information: mark - \(mark),"
            + " model - \(model), maximum speed - \(maximumSpeed),"
            + " maximum heigth - \(maximumHeigth), "
            + " cost - \(getAirplaneCost())"
    }
    
     init (_ initMark: String, _ initModel: String,
        _ initMaximumSpeed: Double, _ initMaximumHeigth: Double) {
        mark = initMark
        model = initModel
        maximumSpeed = initMaximumSpeed
        maximumHeigth = initMaximumHeigth
    }
}