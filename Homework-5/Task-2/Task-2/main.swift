//
//  main.swift
//  Task-2
//
//  Created by konstantin on 11/16/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation
print("Старт программы...")

var fileManager = FileManager()
let collections = DataItemManager.GetDefaultCollections()
print("Внешний вид коллекции до упаковки:")
print("")
print(collections)
let jsonData = DataItemManager.packToJSON(collections)!

print("Вид коллекции после упаковки в JSON:")
print("")
print(JSONManager.getStringFromNSData(jsonData))

fileManager.writeFile(jsonData)
let jsString = fileManager.readFile()

print("Внешний вид коллекции в формате JSON после чтения из файла:")
print("")
print(jsString)


let result = DataItemManager.unpackJSON(jsString)
print("Внешний вид коллекции после распаковки:")
print("")
print(result)


