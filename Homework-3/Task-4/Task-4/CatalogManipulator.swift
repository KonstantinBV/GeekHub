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
    
    init() {
        carsCatalog = Catalog()
        initDefaultCatalog()
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
    
    func showMainActions() {
        var mainActions: [Int : String] = [:]
        mainActions[1] = "Вывести каталог автовладельцев на экран"
        mainActions[2] = "Добавить нового автовладельца в каталог"
        mainActions[3] = "Редактировать данные автовладельца"
        mainActions[4] = "Завершить работу"
        printActions(mainActions)
        if let userInput: Int = Int(readLine()!) {
            switch (userInput) {
                case 1 :
                    printCatalog()
                case 2 :
                    addNewCarOwner()
                case 4 :
                    print("Программа завершила работу.")
                default:
                    runOnError()
            }
        } else {
            runOnError()
        }
    }
    
    private func addNewCarOwner() {
        if let carOwner = carsCatalog.addCarOwner() {
            showCarOwnerActions(carOwner)
        } else {
            showMainActions()
        }
    }
    
    private func showCarOwnerActions(carOwner: CarOwner) {
        var newCarOwnerActions: [Int : String] = [:]
        newCarOwnerActions[1] = "Добавить автомобиль в коллекцию"
        newCarOwnerActions[2] = "Возврат в предыдущее меню"
        newCarOwnerActions[3] = "Завершить работу"
        printActions(newCarOwnerActions)
        if let userInput: Int = Int(readLine()!) {
            switch (userInput) {
            case 1 :
                addCarsForCarOwner(carOwner)
                addNewCarOwner()
            case 2 :
                showMainActions()
            case 3 :
                print("Программа завершила работу.")
            default:
                print("Неверная операция!")
                addNewCarOwner()
            }
        } else {
            print("Неверная операция!")
            addNewCarOwner()
        }

    }
    
    private func addCarsForCarOwner(carOwner: CarOwner) {
        carOwner.addCar()
        print("Желаете повторить операцию?")
        print("1 - да")
        print("Любое другое значение - нет")
        if let yesNoResult: String = readLine() {
            if yesNoResult == "1" {
                self.addCarsForCarOwner(carOwner)
            }
        }
    }
    
    private func printActions(actions: [Int : String]) {
        print("Выберите одну из доступных операций.")
        print("")
        let sortedActions = actions.sort { $0.0 < $1.0 }
        for (actionKey, actionMessage) in sortedActions {
            print("\(actionKey) - \(actionMessage)")
        }
    }
    
    private func runOnError() {
        print("Неверная операция!")
        showMainActions()
    }
    
    private func printCatalog() {
        carsCatalog.printCatalog()
    }
}