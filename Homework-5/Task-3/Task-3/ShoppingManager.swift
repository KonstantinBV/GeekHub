//
//  ShoppingListManager.swift
//  Task-3
//
//  Created by konstantin on 11/23/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class ShoppingManager {
    
    private var shoppingList = ShoppingList()
    
    public func startShopping() {
        print("Доступные операции для списка покупок:")
        print("1 - отобразить на экране.")
        print("2 - сортировать по дате.")
        print("3 - добавить запись.")
        print("4 - удаление записей.")
        print("5 - редактировать запись.")
        print("6 - завершить работу программы.")
        print("")
        print("Введите номер операции")
        if let userInput = Int(readLine()!) {
            switch userInput {
                case 1:
                    shoppingList.printShoppingList()
                    startShopping()
                    break
                case 2:
                    shoppingList.sortByDate()
                    startShopping()
                    break
                case 3:
                    shoppingList.add()
                    startShopping()
                    break
                case 4:
                    removeRecords()
                    break
                case 5:
                    editRecords()
                    break
                case 6:
                    return
                default:
                    print("Ошибка! Недопустимая операция.")
                    print("")
                    startShopping()            }
        } else {
            print("Ошибка! Недопустимая операция.")
            print("")
            startShopping()
        }
    }
    
    private func removeRecords() {
        if !shoppingList.isPurchasesValid() {
            startShopping()
            return
        }
        print("Удаление записей из списка покупок.")
        print("Доступные операции:")
        print("1 - удалить все записи.")
        print("2 - удалить одну запись.")
        print("3 - возврат в предыдущее меню.")
        print("4 - завершить работу программы.")
        print("")
        print("Введите номер операции")
        print("")
        if let userInput = Int(readLine()!) {
            switch userInput {
            case 1:
                shoppingList.removeAll()
                startShopping()
                break
            case 2:
                removeRecord()
                break
            case 3:
                startShopping()
                break
            case 3:
                return
            default:
                print("Ошибка! Недопустимая операция.")
                print("")
                removeRecords()
            }
        } else {
            print("Ошибка! Недопустимая операция.")
            print("")
            removeRecords()
        }
    }
    
    private func removeRecord() {
        if !shoppingList.isPurchasesValid() {
            removeRecords()
            return
        }
        print("Удаление записи из списка покупок.")
        if let purchase = shoppingList.findByIndex() {
            shoppingList.remove(purchase)
            removeRecords()
        } else {
            print("Доступные операции:")
            print("1 - повторить попытку.")
            print("2 - возврат в предыдущее меню.")
            print("3 - завершить работу программы.")
            if let userInput: Int = Int(readLine()!) {
                switch userInput {
                case 1:
                    removeRecord()
                    break
                case 2:
                    removeRecords()
                    break
                case 3:
                    return
                default:
                    print("Ошибка! Недопустимая операция.")
                    print("")
                    startShopping()
                }
            }
            else {
                print("Ошибка! Недопустимая операция.")
                print("")
                removeRecord()
            }
        }
    }
    
    private func editRecords() {
        if !shoppingList.isPurchasesValid() {
            startShopping()
            return
        }
        print("Редактирование записей.")
        if let purchase = shoppingList.findByIndex() {
            print("Выбрана запись: \(purchase.getInfo())")
            print("")
            print("Доступные операции:")
            print("1 - изменить название.")
            print("2 - изменить отметку о выполнении.")
            print("3 - возврат в предыдущее меню.")
            print("4 - завершить работу программы.")
            if let userInput: Int = Int(readLine()!) {
                switch userInput {
                case 1:
                    if let newTitle = readLine() {
                        if newTitle.isEmpty {
                            print("Ошибка. Название не может быть пустым.")
                            print("")
                            editRecords()
                        } else {
                            purchase.setTitle(newTitle)
                        }
                    } else {
                        print("Ошибка. Недопустимый формат данных.")
                        print("")
                        editRecords()
                    }
                    break
                case 2:
                    print("Текущее значение отметки о выполнении: \(purchase.getCheckedInfo())")
                    print("Желаете изменить отметку о выполнении на противоположное значение?")
                    print("1 - да")
                    print("Любое другое значение - возврат в предыдущее меню.")
                    if let userValue = Int(readLine()!) {
                        if userValue == 1 {
                            purchase.setChecked(!purchase.getChecked())
                            print("Значение успешно изменено.")
                        }
                    }
                    editRecords()
                    break
                case 3:
                    startShopping()
                    break
                case 4:
                    return
                default:
                    print("Ошибка! Недопустимая операция.")
                    print("")
                    startShopping()
                }
            }
            else {
                print("Ошибка! Недопустимая операция.")
                print("")
                startShopping()
            }
        } else {
            print("Ошибка выбора покупки.")
            print("")
            startShopping()
        }
    }
}