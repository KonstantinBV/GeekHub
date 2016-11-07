//
//  Garage.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class CarsCollection {
    
    var carOwner: CarOwner!
    var cars: [String:  Car] = [:]
    
    init(carOwner: CarOwner) {
        self.carOwner = carOwner
    }
    
    public func addCar(car: Car!) {
        cars[car.dnz] = car
    }
    
    public func findCar(carDnz: String) -> [Car] {
        var validCars: [Car] = []
        if let dnz: String = Tools.replace(carDnz, " ", "") {
            if !cars.isEmpty && !dnz.isEmpty {
                for (carKey, car) in cars {
                    if carKey.containsString(dnz) {
                        validCars.append(car)
                    }
                }
            }
        }
        return validCars
    }
    
    public func addCar(car: Car, reportProgress: Bool = true) {
        if let existedCar: Car = cars[car.dnz] {
            print("Car \(existedCar.getInfo()) already in garage")
        } else {
            car.carOwner = carOwner
            cars[car.dnz] = car
            if reportProgress {
               print("Car \(car.getInfo()) added to the garage")
            }
        }
    }
    
    public func removeCar(car: Car) {
        if let existedCar: Car = cars[car.dnz] {
            cars.removeValueForKey(existedCar.dnz)
            print("Car \(car.getInfo()) removed...")
        } else {
            print("Car \(car.getInfo()) not found!")
        }
    }
}