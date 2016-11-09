//
//  Garage.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class CarsCollection: Tools {
    
    private var carOwner: CarOwner!
    private var cars: [String:  Car] = [:]
    
    public var isEmpty: Bool { return cars.count == 0 }
    
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
    
    public func editCarCollection() {
        if let selectedItem = selectCarByIndex() {
            showEditCarCollectionActions(selectedItem)
        }
    }
    
    private func showEditCarCollectionActions(selectedItem: (carIndex: Int, car: Car)) {
        print("Выбрана запись: \(selectedItem.car.getInfo())")
        var carActions: [Int : String] = [:]
        carActions[1] = "Изменение данных автомобиля"
        carActions[2] = "Удаление автомобиля"
        carActions[3] = "Возврат в предыдущее меню"
        printActions(carActions)
        if let userInput: Int = Int(readLine()!) {
            switch (userInput) {
            case 1 :
                Car.edit(selectedItem.car)
                editCarCollection()
            case 2 :
                cars.removeValueForKey(selectedItem.car.dnz)
                print("Запись успешно удалена")
                editCarCollection()
            case 3 :
                return
            default:
                print("Неверная операция!")
                showEditCarCollectionActions(selectedItem)
            }
        } else {
            print("Неверная операция!")
            showEditCarCollectionActions(selectedItem)
        }
    }
    
    public func selectCarByIndex() -> (carIndex: Int, car: Car)? {
        if isEmpty {
            print("Каталог пуст.")
        } else {
            let cars: [Car] = getCars()
            printWithIndex(cars, message: "Список автомобилей:")
            print("Введите порядковый номер автомобиля.")
            print("Или нажмите Enter для возврата в предыдущее меню.")
            if let userInput: String = readLine() {
                if !userInput.isEmpty {
                    if let carIndex: Int = Int(userInput) {
                        if let car: Car = cars[carIndex] {
                            return (carIndex: carIndex, car: car)
                        } else {
                            print("Автомобиль с порядковым номером \(carIndex) не найден")
                            selectCarByIndex()
                        }
                    } else {
                        print("Введенное значение не является номером")
                        selectCarByIndex()
                    }
                }
            } else {
                print("Неверная операция!")
                selectCarByIndex()
            }
        }
        return nil
    }
    
    public func getCars() -> [Car] {
        return [Car](cars.values)
    }
}