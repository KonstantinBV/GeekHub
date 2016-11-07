//
//  Catalog.swift
//  Task-4
//
//  Created by konstantin on 11/7/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Catalog {
    
    private var carsOwners: [CarOwner]
    
    init() {
        carsOwners = []
    }
    
    public func addCarOwner(carOwner: CarOwner) {
        carsOwners.append(carOwner)
    }
    
    public func removeCarOwner(carOwner: CarOwner) {
        if carsOwners.contains(carOwner) {
           carsOwners.removeAtIndex(carsOwners.indexOf(carOwner)!)
        }
    }
    
    public func printCatalog() {
        var cars: [Car] = []
        for carOwner in carsOwners {
            if let validCars: [Car] = carOwner.getCars() {
                cars += validCars
            }
        }
        let sortedCars = cars.sort { $0.dnz < $1.dnz }
        for car in sortedCars {
            if let carOwner: CarOwner = car.carOwner {
                print(carOwner.getInfo())
            }
            print(car.getInfo())
            print("")
        }
    }
    
}