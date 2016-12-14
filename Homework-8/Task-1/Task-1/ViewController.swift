//
//  ViewController.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    var selectedTask: Task?
    
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        guard let validTask = selectedTask else {
            return
        }
        if validTask.isNew {
            TaskManager.instance.addTask(validTask)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskTableViewCell
        cell.setTask(TaskManager.instance.getTasks()[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskManager.instance.getTasks().count
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        openEditView(TaskManager.instance.getTasks()[indexPath.row])

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //Private Functions
    
    private func openEditView(task: Task) {
        
        let viewController: ViewControllerTaskEdit = storyboard?.instantiateViewControllerWithIdentifier("ViewControllerTaskEdit") as! ViewControllerTaskEdit
        viewController.task = task
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }
    
    //MARK: Actions
    
    @IBAction func OnAddItemPressed(sender: UIBarButtonItem) {
        
        openEditView(Task())
    }

}

