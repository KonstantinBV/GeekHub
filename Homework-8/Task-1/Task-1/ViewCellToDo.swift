//
//  TaskTableViewCell.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

//MARK: ViewCellToDo - extension

extension ViewCellToDo {
    
    //MARK: Additional Functions
    
    func setItem(toDo: ToDo) {
        
        self.toDo = toDo
        toDoTextLabel.text = toDo.text
        doneSwitcher.on = toDo.isDone
    }
    
}

//MARK: ViewCellToDo - class

class ViewCellToDo: UITableViewCell {

    //MARK: Properties
    
    private var toDo: ToDo?
    
    @IBOutlet weak var doneSwitcher: UISwitch!
    
    @IBOutlet weak var toDoTextLabel: UILabel!
    
    //MARK: Actions
    
    @IBAction func OnDoneSwitched(sender: UISwitch) {
        
        if toDo == nil {
            return
        }
        toDo!.isDone = sender.on
        
    }
    
}
