//
//  ViewControllerTaskEdit.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

extension ViewControllerTaskEdit {
    
    //MARK: Virtual Functions
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        isNewTask = task == nil
        if isNewTask {
            doneSwitcher.hidden = true
        } else {
            taskTextFiled.text = task!.text
            doneSwitcher.on = task!.isDone
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
}

class ViewControllerTaskEdit: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    var task: Task?
    
    var isNewTask = true
    
    @IBOutlet weak var taskTextFiled: UITextField!
    
    @IBOutlet weak var doneSwitcher: UISwitch!   
    
    
    //MARK: Actions
    
    @IBAction func OnSavePressed(sender: UIBarButtonItem) {
        
        let taskText = taskTextFiled.text!
        if taskText.isEmpty {
            return
        }
        
        if isNewTask {
            task = Task()
        }
        
        task!.text = taskText
        task!.isDone = doneSwitcher.on
        
        if isNewTask {
            TaskHelper.instance.addTask(task!)
        }
        
        OnBackPressed(nil)
        
    }
    
    @IBAction func OnBackPressed(sender: UIBarButtonItem?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
