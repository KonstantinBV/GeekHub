//
//  CatalogManipulator.swift
//  Task-4
//
//  Created by konstantin on 11/8/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class CatalogManipulator {
    
    private var carsCatalog: Catalog
    private var actions: [Int : String] = [:]
    
    init() {
        carsCatalog = Catalog()
        initDefaultCatalog()
        initActions()
    }
    
    private func initDefaultCatalog() {
        let abramov = CarOwner("Ivan", "Abramov", "Cherkassy, Chigirinskaya, 6")
        abramov.addCar(Car("BMW", "5", "CA1522AB"), reportProgress: false)
        abramov.addCar(Car("VAZ", "2105", "CA2284MA"), reportProgress: false)
        abramov.addCar(Car("Mazda", "6", "CA5699MB"), reportProgress: false)
        
        let krasnov = CarOwner("Vasiliy", "Krasnov", "Cherkassy, Pionerskaya, 22a")
        krasnov.addCar(Car("VAZ", "2106", "CA1122AH"), reportProgress: false)
        krasnov.addCar(Car("VAZ", "2106", "CA2385MA"), reportProgress: false)
        krasnov.addCar(Car("Lada", "Kalina", "CA5699BB"), reportProgress: false)
        krasnov.addCar(Car("ZAZ", "Lanos", "CA2592BA"), reportProgress: false)
        
        let petrov = CarOwner("Andrey", "Petrov", "Cherkassy, Pionerskaya, 22b")
        petrov.addCar(Car("GAZ", "69", "CA2355AH"), reportProgress: false)
        petrov.addCar(Car("ZAZ", "Forza", "CA9236MA"), reportProgress: false)
        petrov.addCar(Car("Lada", "Kalina", "CA7211BB"), reportProgress: false)
        petrov.addCar(Car("Ford", "Focus", "CA2759BA"), reportProgress: false)
        
        carsCatalog.addCarOwner(abramov)
        carsCatalog.addCarOwner(krasnov)
        carsCatalog.addCarOwner(petrov)
    }
    
    private func initActions() {
        actions[1] = "Вывести каталог автовладельцев на экран"
        actions[2] = "Добавить нового автовладельца"
        actions[3] = "Редактировать данные автовладельца"
        actions[4] = "Завершить работу"
    }
    
    func run() {
        print("Выберите одну из доступных операций.")
        print("")
        let sortedActions = actions.sort { $0.0 < $1.0 }
        for (actionKey, actionMessage) in sortedActions {
            print("\(actionKey) - \(actionMessage)")
        }
        if let userInput: Int = Int(readLine()!) {
            switch (userInput) {
                case 1 :
                    printCatalog()
                case 4 :
                    print("Программа завершила работу.")
                default:
                    runOnError()
            }
        } else {
            runOnError()
        }
    }
    
    private func runOnError() {
        print("Неверная операция!")
        run()
    }
    
    private func printCatalog() {
        carsCatalog.printCatalog()
    }
}