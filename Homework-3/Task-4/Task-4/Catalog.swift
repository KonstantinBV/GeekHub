//
//  Catalog.swift
//  Task-4
//
//  Created by konstantin on 11/7/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Catalog: Tools {
    
    private var carsOwners: [CarOwner]
    
    override init() {
        carsOwners = []
    }

    public func addCarOwner() -> CarOwner? {
        let carOwner: CarOwner = CarOwner()
        if CarOwner.edit(carOwner) {
            carsOwners.append(carOwner)
            print("Автовладелец успешно добавлен в каталог")
            return carOwner
        }        
        return nil
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
        if carsOwners.count == 0 {
            print("Каталог пуст!")
            return
        }
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
    
    public func searchCars(dnz: String) -> [Car] {
        var result: [Car] = []
        for carOwner in carsOwners {
            if let ownerResult: [Car] = carOwner.searchCars(dnz) {
                result += ownerResult
            }
        }
        return result
    }
    
    public func showEditDataActions() {
        if let selectedOwner = selectCarOwnerByIndex() {
            showCarOwnerEditActions(selectedOwner.carOwner, ownerIndex: selectedOwner.ownerIndex)
        }
    }
    
    public func selectCarOwnerByIndex() -> (ownerIndex: Int, carOwner: CarOwner)? {
        if carsOwners.count == 0 {
            print("Каталог пуст.")
        } else {
            printWithIndex(carsOwners, message: "Список автовладельцев:")
            print("Введите номер автовладельца:")
            print("Или нажмите Enter для возврата в предыдущее меню.")
            if let userInput: String = readLine() {
                if !userInput.isEmpty {
                    if let ownerIndex: Int = Int(userInput) {
                        if ownerIndex >= 0 && ownerIndex < carsOwners.count {
                            return (ownerIndex: ownerIndex, carOwner: carsOwners[ownerIndex])
                        } else {
                            print("Автовладельца с номером \(ownerIndex) нет в каталоге")
                            selectCarOwnerByIndex()
                        }
                    } else {
                        print("Введенное значение не является номером")
                        selectCarOwnerByIndex()
                    }
                }
            } else {
                print("Неверная операция!")
                selectCarOwnerByIndex()
            }
        }
        return nil
    }
    
    private func showCarOwnerEditActions(carOwner: CarOwner, ownerIndex:  Int) {
        print("Выбрана запись: \(carOwner.getInfo())")
        var catalogActions: [Int : String] = [:]
        catalogActions[1] = "Изменение данных автовладельца"
        catalogActions[2] = "Удаление автовладельца"
        catalogActions[3] = "Изменение данных автоколлекции"
        catalogActions[4] = "Возврат в предыдущее меню"
        catalogActions[5] = "Завершить работу"
        printActions(catalogActions)
        if let userInput: Int = Int(readLine()!) {
            switch (userInput) {
            case 1 :
                CarOwner.edit(carOwner)
                showEditDataActions()
            case 2 :
                carsOwners.removeAtIndex(ownerIndex)
                print("Запись успешно удалена")
                showEditDataActions()
            case 3 :
                carOwner.editCarCollection()
                showCarOwnerEditActions(carOwner, ownerIndex: ownerIndex)
            case 4 :
                showEditDataActions()
            case 5 :
                print("Программа завершила работу.")
            default:
                print("Неверная операция!")
                showCarOwnerEditActions(carOwner, ownerIndex: ownerIndex)
            }
        } else {
            print("Неверная операция!")
            showCarOwnerEditActions(carOwner, ownerIndex: ownerIndex)
        }
    }
}