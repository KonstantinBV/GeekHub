//
//  ViewControllerTaskEdit.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

class ViewControllerTaskEdit: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    var task: Task?
    @IBOutlet weak var taskTextFiled: UITextField!
    
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if task != nil && !task!.text.isEmpty {
            taskTextFiled.text = task!.text
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    @IBAction func OnSavePressed(sender: UIBarButtonItem) {
        
        if task != nil {
            task!.text = taskTextFiled.text!
        }
        
    }
    
}
