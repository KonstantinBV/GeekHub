//
//  Car.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Car {
    
    private var brand: String
    private var model: String
    public var dnz: String
    public var carOwner: CarOwner?
    
    public var isEmpty: Bool { return brand.isEmpty && model.isEmpty && dnz.isEmpty }
    
    init() {
        brand = ""
        model = ""
        dnz = ""
    }
    
    init(_ inputBrand: String, _ inputModel: String, _ inputDnz: String) {
        brand = inputBrand
        model = inputModel
        dnz = inputDnz
    }
    
    public func getInfo() -> String {        
        return isEmpty ? "Информация о автомобиле отсутствует!" : "Номер - \(dnz), марка - \(brand), модель - \(model)"
    }
}