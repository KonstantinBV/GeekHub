//
//  ViewControllerTaskEdit.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

//MARK: ToDoEditViewController - class

class ToDoEditViewController: UIViewController {

    //MARK: Properties
    
    var toDo: ToDo?
    
    var isNewItem = true
    
    var delegate: ToDoListDelegate?
    
    @IBOutlet weak var taskTextFiled: UITextField!
    
    @IBOutlet weak var doneSwitcher: UISwitch!
    
    @IBOutlet weak var editSettingsView: UIView!
    
    @IBOutlet weak var toDoCreationDate: UILabel!
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        
        taskTextFiled.delegate = self   
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        isNewItem = toDo == nil
        
        if isNewItem {
            editSettingsView.hidden = true
        } else {
            taskTextFiled.text = toDo!.text
            doneSwitcher.on = toDo!.isDone
            toDoCreationDate.text = toDo!.date.dateTimeToString()
        }
    }
    
    //MARK: Actions
    
    @IBAction func onSavePressed(sender: UIBarButtonItem) {
        
        if save() {
             onBackPressed(nil)
        }       
        
    }
    
    @IBAction func onBackPressed(sender: UIBarButtonItem?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //MARK: Private functions
    
    private func save() -> Bool {
        
        let toDoText = taskTextFiled.text!
        if toDoText.isEmpty {
            return false
        }
        
        if isNewItem {
            toDo = ToDo()
        }
        
        toDo!.text = toDoText
        toDo!.isDone = doneSwitcher.on
        
        delegate?.saveItem(toDo!, isNew: isNewItem)
        return true
    }

}

//MARK: extension UITextFieldDelegate

extension ToDoEditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
}
