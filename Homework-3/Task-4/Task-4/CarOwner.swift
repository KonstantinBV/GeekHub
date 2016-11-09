//
//  CarOwner.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class CarOwner: Tools, Equatable, Info {
    
    var name: String
    var surname: String
    var address: String
    var carsCollection: CarsCollection?
    
    public var isEmpty: Bool { return name.isEmpty || surname.isEmpty }
    
    convenience override init() {
        self.init("", "", "")
    }
    
    init(_ inputName: String, _ inputSurname: String, _ inputAddress: String) {
        name = inputName
        surname = inputSurname
        address = inputAddress
        super.init()
        carsCollection = CarsCollection(carOwner: self)
    }
    
    public func searchCars(carDnz: String) -> [Car]? {
         if carsCollection != nil {
            return carsCollection!.searchCars(carDnz)
        }
        print("Операция не может быть выполнена.")
        print("Коллекция = nil")
        return nil
    }
    
    public func addCar() -> Car? {
        let car: Car = Car()
        if Car.edit(car) {
            addCar(car)
            return car
        }     
        return nil
    }
    
    public func addCar(car: Car, reportProgress: Bool = true) {
        if carsCollection != nil {
            carsCollection!.addCar(car, reportProgress: reportProgress)
        }
    }
    
    public func removeCar() -> Bool {
        if let selectedItem = selectCarByIndex() {
            removeCar(selectedItem.car)
            return true
        }
        return false
    }
    
    public func removeCar(car: Car) {
        if carsCollection != nil {
            carsCollection!.removeCar(car)
        } else {
            print("Операция не может быть выполнена.")
            print("Коллекция = nil")
        }
    }   
    
    public func selectCarByIndex() -> (carIndex: Int, car: Car)? {
        if carsCollection == nil || carsCollection!.isEmpty {
            print("Каталог пуст.")
            return nil
        } else {
            return carsCollection!.selectCarByIndex()
        }
    }
    
    public func getCars() -> [Car] {
        if carsCollection != nil {
           return carsCollection!.getCars()
        }
        print("Операция не может быть выполнена.")
        print("Коллекция = nil")
        return []
    }
    
    public func editCarCollection() {
        if carsCollection != nil {
            carsCollection!.editCarCollection()
        } else {
            print("Операция не может быть выполнена.")
            print("Коллекция = nil")
        }
    }
    
    public static func edit(carOwner: CarOwner) -> Bool {
        if !carOwner.isEmpty {
            print(carOwner.getInfo())
        }        
        print("Введите имя")
        if let name: String = readLine() {
            carOwner.name = name
        }
        print("Введите фамилию")
        if let surname: String = readLine() {
            carOwner.surname = surname
        }
        print("Введите адрес")
        if let address: String = readLine() {
            carOwner.address = address
        }
        if !carOwner.isEmpty {
            return true
        }
        print("Ошибка. Имя и фамилия - обязательные поля.")
        print("Желаете повторить операцию?")
        print("1 - да")
        print("Любое другое значение - нет")
        if let yesNoResult: String = readLine() {
            if yesNoResult == "1" {
                edit(carOwner)
            }
        }
        return false
    }
    
    public func getInfo() -> String {
        return isEmpty ? "Информация о владельце автомобиля отсутствует!" : "\(name) \(surname), адрес: \(address)"
    }   
    
}

public func == (lhs: CarOwner, rhs: CarOwner) -> Bool {
    return lhs == rhs
}