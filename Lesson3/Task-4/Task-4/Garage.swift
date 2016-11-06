//
//  Garage.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Garage {
    
    public var carOwner: CarOwner?
    public var cars: [String : Car]?
    public var isEmpty: Bool { return carOwner == nil && cars == nil }
    
}