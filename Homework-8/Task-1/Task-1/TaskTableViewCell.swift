//
//  TaskTableViewCell.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    private var task: Task?
    
    @IBOutlet weak var doneSwitcher: UISwitch!
    @IBOutlet weak var taskTextLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    func setTask(task: Task) {
        
        self.task = task
        taskTextLabel.text = task.text
        if task.isDone {
            doneSwitcher.setOn(true, animated: true)
        } else {
            doneSwitcher.setOn(false, animated: true)
        }
        
    }
    
    @IBAction func OnDoneSwitched(sender: UISwitch) {
        
        if task == nil {
            return
        }
        task!.isDone = sender.on
        
    }
    
    
    @IBAction func OnDeletePressed(sender: UIButton) {

    }
    
}
