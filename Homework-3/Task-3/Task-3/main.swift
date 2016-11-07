//
//  main.swift
//  Task-3
//
//  Created by konstantin on 11/2/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

let boing777 = Airplane(initMark: "boing", initModel: "777", initMaximumSpeed: 500, initMaximumHeigth: 10000)
let b22 = Bomber(initMark: "B", initModel: "22", initMaximumSpeed: 700, initMaximumHeigth: 13000)
let f16 = Fighter(initMark: "F", initModel: "16", initMaximumSpeed: 1500, initMaximumHeigth: 15000)


print(boing777.getAirplaneInfo())
print("")
print(b22.getAirplaneInfo())
print("")
print(f16.getAirplaneInfo())

