//
//  Created by konstantin on 12/19/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

protocol ToDoMessageDelegate {
    
    func showMessage(title: String, text: String)
    
}

protocol ToDoListDelegate: ToDoMessageDelegate {
    
    func saveItem(toDo: ToDo, isNew: Bool)
    
}

protocol ToDoCellDelegate: ToDoMessageDelegate  {
    
    func updateToDoOnDoneChanged(cell: ViewCellToDo)
    
}