//
//  File.swift
//  Task-2
//
//  Created by konstantin on 11/22/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class FileManager {
    
    let jsonFileName = "json-file.json"
    let fileManager = NSFileManager.defaultManager()
    var jsonFilePath = ""
    
    init(){
        print("Инициализация файлового менеджера...")
        jsonFilePath = fileManager.currentDirectoryPath + "/" + jsonFileName
    }
    
    public func writeFile(data: NSData) {
        print("Запись данных в файл...")
        if !fileManager.createFileAtPath(jsonFilePath, contents: data, attributes: nil) {
            print("Ошибка")
        }
    }
    
    public func readFile() -> String {
        do {
            print("Чтение из файла в строку...")
            return try String(contentsOfFile: jsonFilePath, encoding: NSUTF8StringEncoding)
        }
        catch {
            print("Ошибка чтения данных")
        }
        return ""
    }    
}