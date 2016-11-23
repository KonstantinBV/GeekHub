//
//  ShoppingList.swift
//  Task-3
//
//  Created by konstantin on 11/22/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class ShoppingList {
    
    public var purchases = [Purchase]()
    private var fileManager = FileManager()
    
    init() {
        load()
    }
    
    public func sortByDate() {
        if isPurchasesValid() {
            purchases = purchases.sort { $0.getDate().isLessThanDate($1.getDate()) }
            print("Завершена сортировка списка покупок.")
        }
    }
    
    public func add() {
        print("Введите наименование покупки.")
        if let userInput = readLine() {
            add(userInput)
        }
    }
    
    public func add(title: String) {
        if !title.isEmpty {
            add(Purchase(title))
        } else {
            print("Ошибка. Название не может быть пустым.")
        }
    }
    
    public func add(purchase: Purchase) {
        purchases.append(purchase)
        print("Запись: \(purchase.getInfo()) успешно добавлена.")
        save()
    }
    
    public func removeAll() {
        if isPurchasesValid() {
            purchases = []
            print("Записи удалены успешно!")
            save()
        }
    }
        
    public func remove(title: String) {
        if isPurchasesValid() {
            if !title.isEmpty {
                remove(Purchase(title))
            } else {
                print("Ошибка. Название не может быть пустым.")
            }
        }
    }
    
    public func remove(purchase: Purchase) {
        if isPurchasesValid() {
            if let validPurchase = find(purchase.getTitle()) {
                purchases.removeAtIndex(validPurchase.collectionIndex)
                print("Запись удалена успешно!")
                save()
            }
        }
    }
    
    public func findByIndex() -> Purchase? {
        if !isPurchasesValid() {
            return nil
        }
        let printStep = 1;
        printShoppingList(printStep)
        print("Введите порядковый номер записи:")
        if let userInput:String = readLine() {
            if !userInput.isEmpty {
                if let index: Int = Int(userInput) {
                    let validIndex = index - printStep
                    if validIndex < 0 || validIndex >= purchases.count {
                        print("В коллекции отсутствует запись с порядковым номером - \(index)")
                    } else {
                        return purchases[validIndex]
                    }
                } else {
                    print("Ошибка. Вы ввели не числовое значение.")
                    return nil
                }
            } else {
                return nil
            }
        }
        return nil
    }
    
    public func find(title: String) -> (collectionIndex: Int, purchase: Purchase)? {
        if !title.isEmpty {
            for (index, value) in purchases.enumerate() {
                if value.getTitle() == title {
                    return (collectionIndex: index, purchase: value)
                }
            }
        }
        print("Элемент с названием '\(title)' не обнаружен.")
        return nil
    }
    
    public func printShoppingList(step: Int = 0) {
        if isPurchasesValid() {
            print("")
            print("Список покупок:")
            print("")
            for (index, purchase) in purchases.enumerate() {
                print("\(index + (step < 0 ? 0 : step)) - \(purchase.getInfo())")
            }
            print("")
        }
    }
    
    public func isPurchasesValid() -> Bool {
        if purchases.count > 0 {
            return true
        }
        print("Список покупок пуст.")
        return false
    }
    
    private func save() {
        let purchasesData = PurchasesJSONParser.toJSONDictionary(purchases)
        if let jsonData = JSONManager.convertObjectToJSONData(purchasesData){
            fileManager.writeFile(jsonData)
        }
    }
    
    private func load() {
        if let jsonString: String = fileManager.readFile() {
            if let tmpPurchases: [Purchase] = PurchasesJSONParser.fromJSONFormat(jsonString) {
                purchases = tmpPurchases
            }
        }
    }
}