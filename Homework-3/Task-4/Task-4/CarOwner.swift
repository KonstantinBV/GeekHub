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
    
    public var isEmpty: Bool { return name.isEmpty || surname.isEmpty }
    
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
    
    public func searchCars(carDnz: String) -> [Car]? {
        return carsCollection!.searchCars(carDnz)
    }
    
    public func addCar() -> Car? {
        let car: Car = Car()
        print("Введите марку")
        if let brand: String = readLine() {
            car.brand = brand
        }
        print("Введите модель")
        if let model: String = readLine() {
            car.model = model
        }
        if let dnz: String = getDnz() {
            car.dnz = dnz
        }
        if !car.isEmpty {
            self.addCar(car)            
            return car
        }
        print("Ошибка. Все поля обязательны для введения.")
        print("Желаете повторить операцию?")
        print("1 - да")
        print("Любое другое значение - нет")
        if let yesNoResult: String = readLine() {
            if yesNoResult == "1" {
                self.addCar()
            }
        }
        return nil
    }
    
    public func addCar(car: Car, reportProgress: Bool = true) {
        carsCollection!.addCar(car, reportProgress: reportProgress)
    }
    
    public func removeCar() -> Bool {
        let cars: [Car] = carsCollection!.getCars()
        if cars.count == 0 {
            print("Информация для удаления отсутствует.")
            print("Коллекция автомобилей пуста.")
        } else {
            print("Список автомобилей:")
            for (index, car) in cars.enumerate() {
                print("\(index) - \(car.getInfo())")
            }
            print("Введите порядковый номер автомобиля для продолжения операции удаления.")
            print("Или нажмите Enter для возврата в предыдущее меню.")
            if let userInput: String = readLine() {
                if !userInput.isEmpty {
                    if let carIndex: Int = Int(userInput) {
                        if let car: Car = cars[carIndex] {
                            removeCar(car)
                        } else {
                            print("Автомобиль с порядковым номером \(carIndex) не найден")
                            removeCar()
                        }
                    } else {
                        print("Введенное значение не является номером")
                        removeCar()
                    }
                }
            } else {
                print("Неверная операция!")
                removeCar()
            }
        }

        return false
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
    
    private func getDnz() -> String? {
        var result: String?
        print("Введите гос. номер")
        if let dnz: String = readLine() {
            if dnz.characters.count > 10 {
                print("Неверный формат гос. номера.")
                print("Длина гос. номера не должна превышать 10 символов.")
                print("Желаете повторить операцию?")
                print("1 - да")
                print("Любое другое значение - нет")
                if let yesNoResult: String = readLine() {
                    if yesNoResult == "1" {
                        result = self.getDnz()
                    }
                }
            } else {
                result = dnz
            }
        }
        return result
    }
}

public func == (lhs: CarOwner, rhs: CarOwner) -> Bool {
    return lhs == rhs
}