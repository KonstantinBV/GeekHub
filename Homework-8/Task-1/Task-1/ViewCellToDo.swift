//
//  TaskTableViewCell.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

//MARK: ViewCellToDo - class

class ViewCellToDo: UITableViewCell {

    //MARK: Members
    
    private var toDoInstance: ToDo?
    
    
    //MARK: Properties
    
    @IBOutlet weak var doneSwitcher: UISwitch!
    
    @IBOutlet weak var toDoTextLabel: UILabel!
    
    var toDo: ToDo? {
        
        get {
            return toDoInstance
        }
        
        set {
            toDoInstance = newValue
            toDoTextLabel.text = newValue?.text
            doneSwitcher.on = (newValue?.isDone) ?? false
        }
        
    }   
    
    //MARK: Actions
    
    @IBAction func OnDoneSwitched(sender: UISwitch) {
        
        if toDo != nil {
            toDo!.isDone = sender.on
        }
    }
    
}
