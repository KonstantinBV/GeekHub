//
//  CatalogManipulator.swift
//  Task-4
//
//  Created by konstantin on 11/8/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class CatalogManipulator: Tools {
    
    private var carsCatalog: Catalog
    
    init(catalog: Catalog) {
        carsCatalog = catalog
    }
    convenience override init() {
        self.init(catalog: Catalog())
        initDefaultCatalog()
    }
    
    private func initDefaultCatalog() {
        let abramov = CarOwner("Иван", "Абрамов", "Черкассы, Чигиринская, 6")
        abramov.addCar(Car("BMW", "5", "СА1522МВ"), reportProgress: false)
        abramov.addCar(Car("ВАЗ", "2105", "СА3698АА"), reportProgress: false)
        abramov.addCar(Car("Mazda", "6", "СА5936АР"), reportProgress: false)
        
        let krasnov = CarOwner("Василий", "Краснов", "Черкассы, Пионерская, 22а")
        krasnov.addCar(Car("ВАЗ", "2106", "СА1122АН"), reportProgress: false)
        krasnov.addCar(Car("ВАЗ", "2106", "СА2385МА"), reportProgress: false)
        krasnov.addCar(Car("Lada", "Kalina", "СА5699ВВ"), reportProgress: false)
        krasnov.addCar(Car("ЗАЗ", "Lanos", "СА2592ВА"), reportProgress: false)
        
        let petrov = CarOwner("Андрей", "Петров", "Черкассы, Пионерская, 22б")
        petrov.addCar(Car("ГАЗ", "69", "СА2355АН"), reportProgress: false)
        petrov.addCar(Car("ЗАЗ", "Forza", "СА9236МН"), reportProgress: false)
        petrov.addCar(Car("Lada", "Kalina", "СА7723МС"), reportProgress: false)
        petrov.addCar(Car("Ford", "Focus", "СА1105РР"), reportProgress: false)
        
        carsCatalog.addCarOwner(abramov)
        carsCatalog.addCarOwner(krasnov)
        carsCatalog.addCarOwner(petrov)
    }
    
    func showMainActions() {
        var mainActions: [Int : String] = [:]
        mainActions[1] = "Вывести каталог автовладельцев на экран"
        mainActions[2] = "Добавить нового автовладельца в каталог"
        mainActions[3] = "Редактировать данные каталога"
        mainActions[4] = "Поиск по номерногу знаку"
        mainActions[5] = "Завершить работу"
        printActions(mainActions)
        if let userInput: Int = Int(readLine()!) {
            switch (userInput) {
                case 1 :
                    printCatalog()
                    showMainActions()
                case 2 :
                    addNewCarOwner()
                case 3 :
                    showCatalogActions()
                case 4 :
                    searchCars()
                    showMainActions()
                case 5 :
                    print("Программа завершила работу.")
                default:
                    print("Неверная операция!")
                    showMainActions()
            }
        } else {
            print("Неверная операция!")
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
                showCarOwnerActions(carOwner)
            }
        } else {
            print("Неверная операция!")
            showCarOwnerActions(carOwner)
        }
    }
    
    private func showCatalogActions() {
        var catalogActions: [Int : String] = [:]
        catalogActions[1] = "Редактирование данных каталога"
        catalogActions[2] = "Удаление данных каталога"
        catalogActions[3] = "Возврат в предыдущее меню"
        catalogActions[4] = "Завершить работу"
        printActions(catalogActions)
        if let userInput: Int = Int(readLine()!) {
            switch (userInput) {
            case 1 :
                carsCatalog.editData()
                showCatalogActions()
            case 2 :
                carsCatalog.removeData()
                showCatalogActions()
            case 3 :
                showMainActions()
            case 4 :
                print("Программа завершила работу.")
            default:
                print("Неверная операция!")
                showCatalogActions()
            }
        } else {
            print("Неверная операция!")
            showCatalogActions()
        }
    }
    
    private func searchCars() {
        var searchResult: [Car] = []
        print("Для поиска введите номерной знак или часть номерного")
        if let userInput: String = readLine() {
            if userInput.isEmpty {
                print("Ошибка.")
                print("Значение номерного знака не может быть пустым!")
                searchCars()
                return
            }
            searchResult = carsCatalog.searchCars(userInput)
            if !searchResult.isEmpty {
                print("Обнаружено \(searchResult.count) совпадений:")
                for (carIndex, car) in searchResult.enumerate() {
                    print("")
                    print("<\(carIndex + 1)>")
                    print("\(car.getInfo())")
                    print("\(car.carOwner!.getInfo())")
                    print("</\(carIndex + 1)>")
                }
            } else {
                print("Совпадения не обнаружены")
            }
        }
    }
    
    private func addNewCarOwner() {
        if let carOwner = carsCatalog.addCarOwner() {
            showCarOwnerActions(carOwner)
        } else {
            showMainActions()
        }
    }
    
    private func addCarsForCarOwner(carOwner: CarOwner) {
        carOwner.addCar()
        print("Желаете добавить автомобиль в коллекцию?")
        print("1 - да")
        print("Любое другое значение - нет")
        if let yesNoResult: String = readLine() {
            if yesNoResult == "1" {
                self.addCarsForCarOwner(carOwner)
            } else {
                showCarOwnerActions(carOwner)
            }
        }
    }   
    
    private func printCatalog() {
        carsCatalog.printCatalog()
    }
}