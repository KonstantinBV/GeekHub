//
//  Vertex.swift
//  ServeSeattle-Test
//
//  Created by konstantin on 1/25/17.
//  Copyright © 2017 konstantin. All rights reserved.
//

import Foundation

//MARK: Structure

public struct Vertex<T where T: Equatable, T: Hashable>: Equatable  {
    
    public var data: T
    public let index: Int
    
}

//MARK: Extensions

extension Vertex: CustomStringConvertible {
    
    public var description: String {
        get {
            return "\(index): \(data)"
        }
    }
    
}

extension Vertex: Hashable {
    
    public var hashValue: Int {
        get {
            return "\(data)\(index)".hashValue
        }
    }
    
}

public func ==<T: Equatable>(lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
    guard lhs.index == rhs.index else {
        return false
    }
    
    guard lhs.data == rhs.data else {
        return false
    }
    
    return true
}
