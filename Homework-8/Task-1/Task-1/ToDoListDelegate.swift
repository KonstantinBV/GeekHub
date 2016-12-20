//
//  Created by konstantin on 12/19/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

protocol ToDoListDelegate {
    
    func saveItem(toDo: ToDo, isNew: Bool)
    
    func onDoneSwitched()
    
}
