//
//  Car.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Car {
    
    public var mark: String = ""
    public var model: String = ""
    public var dnz: String = ""
    
    public var carOwner: CarOwner?
    
    init (_ inputMark: String, _ inputModel: String, _ inputDnz: String, _ inputCarOwner: CarOwner?) {
        mark = inputMark
        model = inputModel
        dnz = inputDnz
        carOwner = inputCarOwner
    }
    
}