//
//  main.swift
//  Task-2
//
//  Created by konstantin on 11/16/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation
print("Старт программы...")

print("Инициализация манипулятора...")
var manipulator = JSONManipulator()
print("Инициализация коллекции DataItem...")
print("")
let collections = DataItem.InitCollections()
print(collections)
print("")
let jsonData = manipulator.packToJSON(collections)!
print("Вид коллекции после упаковки в JSON:")
print("")
print(manipulator.getStringFromNSData(jsonData))
print("")
print("Запись данных в файл...")
manipulator.writeFile(jsonData)
print("Чтение из файла в строку...")
let jsString = manipulator.readFile()
print("Внешний вид коллекции в формате JSON после чтения из файла:")
print("")
print(jsString)
print("Распаковка строки в формате JSON в коллекцию...")
let result = manipulator.unpackJSON(jsString)
print("")
print("Внешний вид коллекции после распаковки:")
print("")
print(result)


