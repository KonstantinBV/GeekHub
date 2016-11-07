//
//  Car.swift
//  Task-4
//
//  Created by konstantin on 11/6/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class Car {
    
    var mark: String
    var model: String
    public var dnz: String
    public var carOwner: CarOwner?
    
    public var isEmpty: Bool { return mark.isEmpty && model.isEmpty && dnz.isEmpty }
    
    init() {
        mark = ""
        model = ""
        dnz = ""
    }
    
    init(_ inputMark: String, _ inputModel: String, _ inputDnz: String) {
        mark = inputMark
        model = inputModel
        dnz = inputDnz
    }
    
    public func getInfo() -> String {
        var mainInfo = isEmpty ? "No car info!" : "\(dnz), \(mark), \(model)"
        if let subInfo: String = carOwner!.getInfo() {
            mainInfo.appendContentsOf(", " + subInfo)
        }
        return mainInfo
    }
}