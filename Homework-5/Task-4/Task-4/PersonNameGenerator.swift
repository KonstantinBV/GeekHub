//
//  PersonNameGenerator.swift
//  Task-4
//
//  Created by konstantin on 12/3/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class PersonNameGenerator {
    
    private var namesMale: NSArray = [String]()
    private var namesFemale: NSArray = [String]()
    private var surnames: NSArray = [String]()
    
    public var isEmpty: Bool { return namesFemale.count > 0 || surnames.count == 0 || namesMale.count == 0 }
    
    public func loadData() -> Bool {
        
        print("Начало загрузки информации из файлов с именами...")
        
        namesMale = getFromJson("names_male")
        namesFemale = getFromJson("names_female")
        surnames = getFromJson("surnames")
        
        if namesMale.count > 0 && namesFemale.count > 0 && surnames.count > 0 {
            print("Загрузка успешно завершена!")
            return true
        } else {
            print("Ошибка загрузки данных!")
            return false
        }
    }
    
    public func clearData() {
        
        namesMale = []
        namesFemale = []
        surnames = []
        
    }
    
    public func setRandomName(var person: Person) {
        
        person.name = getRandomData(person.sex!)
        person.surname = getRandomData(person.sex!, getSurname: true)
        
    }
    
    private func getRandomData(sex: Sex, getSurname: Bool = false) -> String {
        
        if getSurname {
            return surnames.getRandomString()
        }
        
        switch sex {
            case Sex.Male:
                return namesMale.getRandomString()
            case Sex.Female:
                return namesFemale.getRandomString()
        }
    }
    
    private func getFromJson(fileName: String) -> [String] {
        
        guard let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json") else {
            print("Ошибка! Файл '\(fileName)' не найден.")
            return []
        }
        let fileData = try! NSData(contentsOfFile: filePath, options: NSDataReadingOptions.DataReadingMapped)
        guard let jsonData = JSONManager.getFromNSData(fileData) else {
            return []
        }
        guard let data: [String] = jsonData as? [String] else {
            return[]
        }
        
        return data
        
    }

}
