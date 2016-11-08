//
//  Garage.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class CarsCollection {
    
    private var carOwner: CarOwner!
    private var cars: [String:  Car] = [:]
    
    init(carOwner: CarOwner) {
        self.carOwner = carOwner
    }
    
    public func addCar(car: Car!) {
        cars[car.dnz] = car
    }
    
    public func searchCars(carDnz: String) -> [Car] {
        var validCars: [Car] = []
        if let dnz: String = Tools.replace(carDnz, " ", "") {
            if !cars.isEmpty && !dnz.isEmpty {
                for (carKey, car) in cars {
                    if carKey.lowercaseString.containsString(dnz.lowercaseString) {
                        validCars.append(car)
                    }
                }
            }
        }
        return validCars
    }
    
    public func addCar(car: Car, reportProgress: Bool = true) {
        if let existedCar: Car = cars[car.dnz] {
            print("Ошибка!")
            print("Авто: \(existedCar.getInfo()) уже находится в коллекции.")
        } else {
            car.carOwner = carOwner
            cars[car.dnz] = car
            if reportProgress {
               print("Авто: \(car.getInfo()) успешно добавлено в коллекцию!")
            }
        }
    }
    
    public func removeCar(car: Car) {
        if let existedCar: Car = cars[car.dnz] {
            cars.removeValueForKey(existedCar.dnz)
            print("Авто: \(car.getInfo()) удалено из коллекции!")
        } else {
            print("Ошибка удаления.")
            print("Авто: \(car.getInfo()) не состоит в коллекции!")
        }
    }
    
    public func getCars() -> [Car] {
        return [Car](cars.values)
    }
}