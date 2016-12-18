//
//  TaskTableViewCell.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

extension ViewCellTask {
    
    //MARK; Additional Functions
    
    func setTask(task: Task) {
        
        self.task = task
        taskTextLabel.text = task.text
        doneSwitcher.on = task.isDone
    }
    
}

class ViewCellTask: UITableViewCell {

    //MARK: Properties
    
    private var task: Task?
    
    @IBOutlet weak var doneSwitcher: UISwitch!
    
    @IBOutlet weak var taskTextLabel: UILabel!
    
    //MARK: Actions
    
    @IBAction func OnDoneSwitched(sender: UISwitch) {
        
        if task == nil {
            return
        }
        task!.isDone = sender.on
        
    }
    
}
