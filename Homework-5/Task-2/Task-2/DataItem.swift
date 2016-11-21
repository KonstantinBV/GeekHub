//
//  Strings.swift
//  Task-2
//
//  Created by konstantin on 11/17/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class DataItem {
    public var name: String
    public var value: String
    
    init() {
        name = ""
        value = ""
    }
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    public static func InitCollections() -> [(collectionName: String, collection: [DataItem])] {
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
}
