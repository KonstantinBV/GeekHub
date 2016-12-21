//
//  Utilities.swift
//  Task-2
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation
import UIKit

public class Utilities {
    
    public static func doSomethingAssync(someFunc: () -> ()) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                someFunc()
            }
        }
        
    }
    
}