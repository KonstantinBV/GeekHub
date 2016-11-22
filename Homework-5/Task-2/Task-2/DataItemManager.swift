//
//  DataItemManager.swift
//  Task-2
//
//  Created by konstantin on 11/22/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class DataItemManager {
    
    public static func GetDefaultCollections() -> [(collectionName: String, collection: [DataItem])] {
        print("Инициализация коллекции DataItem...")
        var dataItems = [DataItem]()
        dataItems.append(DataItem(name: "first_item", value: "name1"))
        dataItems.append(DataItem(name: "second_item", value: "name2"))
        dataItems.append(DataItem(name: "third_item", value: "name3"))
        var subDataItems = [DataItem]()
        subDataItems.append(DataItem(name: "sub_string_first_item", value: "name_sub_1".removeEverySecondCharacter()))
        subDataItems.append(DataItem(name: "sub_string_second_item", value: "name_sub_2".replaceEveryThirdCharacter("T")))
        subDataItems.append(DataItem(name: "sub_string_third_item", value: "name_sub_3_test_sub_strings".refillByValues("R", step: 4)))
        var collections = [(collectionName: String, collection: [DataItem])]()
        collections.append((collectionName: "data_items", collection: dataItems))
        collections.append((collectionName: "sub_data_items", collection: subDataItems))
        return collections
    }

    public static func packToJSON(inputItems:[(collectionName: String, collection: [DataItem])]) -> NSData? {
        var objectsData = [String: [String: String]]()
        for inputItem in inputItems {
            objectsData[inputItem.collectionName] = [String: String]()
            for dataItem in inputItem.collection {
                objectsData[inputItem.collectionName]![dataItem.name] = dataItem.value
            }
        }
        return objectsData.isEmpty ? nil : JSONManager.convertObjectToJSONData(objectsData)
    }
    
    public static func unpackJSON(jsonString: String) -> [(collectionName: String, collection: [DataItem])] {
        print("Распаковка строки в формате JSON в коллекцию...")
        var result = [(collectionName: String, collection: [DataItem])]()
        if !jsonString.isEmpty {
            do {
                let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                let object = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
                if let jsDict = object as? NSDictionary {
                    for jsDictionaryItem in jsDict {
                        if let key = jsDictionaryItem.key as? String {
                            if let cortages = jsDictionaryItem.value as? NSDictionary {
                                var dataItems = [DataItem]()
                                for cortage in cortages {
                                    dataItems.append(DataItem(name: cortage.key as! String, value: cortage.value as! String))
                                }
                                result.append((collectionName: key, collection: dataItems))
                            }
                        }
                    }
                }
            } catch {
                print("Ошибка распаковки!")
            }
        }
        return result
    }

}