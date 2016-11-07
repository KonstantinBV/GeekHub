//
//  CarOwner.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class CarOwner: Equatable {
    
    var name: String
    var surname: String
    var address: String
    var carsCollection: CarsCollection?
    
    public var isEmpty: Bool { return name.isEmpty && surname.isEmpty }
    
    init() {
        name = ""
        surname = ""
        address = ""
        carsCollection = CarsCollection(carOwner: self)
    }
    
    convenience init(_ inputName: String, _ inputSurname: String, _ inputAddress: String) {
        self.init()
        name = inputName
        surname = inputSurname
        address = inputAddress
    }
    
    public func findCar(carDnz: String) -> [Car]? {
        return carsCollection!.findCar(carDnz)
    }
    
    public func addCar(car: Car, reportProgress: Bool = true) {
        carsCollection!.addCar(car, reportProgress: reportProgress)
    }
    
    public func removeCar(car: Car) {
        carsCollection!.removeCar(car)
    }
    
    public func getCars() -> [Car] {
        return carsCollection!.getCars()
    }
    
    public func getInfo() -> String {
        return isEmpty ? "Информация о владельце автомобиля отсутствует!" : "\(name) \(surname), адрес: \(address)"
    }
}

public func == (lhs: CarOwner, rhs: CarOwner) -> Bool {
    return lhs == rhs
}