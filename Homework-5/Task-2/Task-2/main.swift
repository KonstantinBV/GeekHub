//
//  main.swift
//  Task-2
//
//  Created by konstantin on 11/16/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

var manipulator = JSONManipulator()

var strings = [DataItem]()
strings.append(DataItem(name: "first_item", value: "name1"))
strings.append(DataItem(name: "second_item", value: "name2"))
strings.append(DataItem(name: "third_item", value: "name3"))

var subStrings = [DataItem]()
subStrings.append(DataItem(name: "sub_string_first_item", value: "name_sub_1"))
subStrings.append(DataItem(name: "sub_string_second_item", value: "name_sub_2"))
subStrings.append(DataItem(name: "sub_string_third_item", value: "name_sub_3"))


var collections = [(collectionName: String, collection: [DataItem])]()
collections.append((collectionName: "data_items", collection: strings))
collections.append((collectionName: "sub_data_items", collection: subStrings))

manipulator.writeFile(manipulator.packToJSON(collections)!)
