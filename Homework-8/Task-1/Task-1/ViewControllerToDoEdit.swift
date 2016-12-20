//
//  ViewControllerTaskEdit.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

//MARK: ViewControllerToDoEdit - extension

extension ViewControllerToDoEdit {
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        
        taskTextFiled.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        isNewItem = toDo == nil
        
        if isNewItem {
            doneSwitcher.hidden = true
        } else {
            taskTextFiled.text = toDo!.text
            doneSwitcher.on = toDo!.isDone
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    //MARK: Private functions
    
    private func save() {
        
        let toDoText = taskTextFiled.text!
        if toDoText.isEmpty {
            return
        }
        
        if isNewItem {
            toDo = ToDo()
        }
        
        toDo!.text = toDoText
        toDo!.isDone = doneSwitcher.on
        delegate?.addItem(toDo!)
    }
    
}

//MARK: ViewControllerToDoEdit - class

class ViewControllerToDoEdit: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    var toDo: ToDo?
    
    var isNewItem = true
    
    var delegate: ToDoListDelegate?
    
    @IBOutlet weak var taskTextFiled: UITextField!
    
    @IBOutlet weak var doneSwitcher: UISwitch!   
    
    
    //MARK: Actions
    
    @IBAction func onSavePressed(sender: UIBarButtonItem) {
        
        save()
        onBackPressed(nil)
        
    }
    
    @IBAction func onBackPressed(sender: UIBarButtonItem?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
