//
//  Car.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Car: Info {
    
    var brand: String
    var model: String
    var dnz: String
    var carOwner: CarOwner?
    
    public var isEmpty: Bool { return brand.isEmpty || model.isEmpty || dnz.isEmpty }
    
    init() {
        brand = ""
        model = ""
        dnz = ""
    }
    
    init(_ inputBrand: String, _ inputModel: String, _ inputDnz: String) {
        brand = inputBrand
        model = inputModel
        dnz = inputDnz
    }
    
    public static func edit(car: Car) -> Bool {
        if !car.isEmpty {
            print(car.getInfo())
        }
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
            return true
        }
        print("Ошибка. Все поля обязательны для введения.")
        print("Желаете повторить операцию?")
        print("1 - да")
        print("Любое другое значение - нет")
        if let yesNoResult: String = readLine() {
            if yesNoResult == "1" {
                edit(car)
            }
        }
        return false
    }
    
    private static func getDnz() -> String? {
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
    
    public func getInfo() -> String {        
        return isEmpty ? "Информация о автомобиле отсутствует!" : "Номер - \(dnz), марка - \(brand), модель - \(model)"
    }
}