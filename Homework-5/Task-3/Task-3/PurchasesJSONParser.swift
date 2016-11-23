//
//  PurchasesJSONParser.swift
//  Task-3
//
//  Created by konstantin on 11/23/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class PurchasesJSONParser {
    
    public static func toJSONDictionary(purchases: [Purchase]) -> [Dictionary<String, String>] {
        var result = [Dictionary<String, String>]()
        for purchase in purchases {
            let mirror = Mirror(reflecting: purchase)
            var childrens = [(label: String?, value: Any)]()
            if let coll = AnyRandomAccessCollection(mirror.children) {
                childrens += coll
            }
            
            var childrensDict = Dictionary<String, String>()
            for children in childrens {
                childrensDict[children.label!] = children.value is NSDate
                    ? (children.value as! NSDate).dateTimeToString()
                    : String(children.value)
            }
            result.append(childrensDict)
        }
        return result
    }
    
    public static func fromJSONFormat(jsonString: String) -> [Purchase] {
        var result = [Purchase]()
        if !jsonString.isEmpty {
            do {
                let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                let object = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
                if let jsonArray = object as? NSArray {
                    for arrayItem in jsonArray {
                        if let properties = arrayItem as? NSDictionary {
                            let purchase = Purchase()
                            for property in properties {
                                if let key: String = String(property.key) {
                                    if let value: String = String(property.value) {
                                        switch key {
                                            case "title":
                                                purchase.setTitle(value)
                                                break
                                            case "date":
                                                purchase.setDate(value.toDateTime())
                                                break
                                            case "date":
                                                purchase.setChecked(value.toBool())
                                                break
                                            default:
                                                break
                                        }
                                    }
                                }
                            }
                            result.append(purchase)
                        }
                    }
                }

                
            } catch {
                return []
            }
        }
        return result
    }
}