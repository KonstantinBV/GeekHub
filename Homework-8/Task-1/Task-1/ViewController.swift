//
//  ViewController.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

extension ViewController {
    
    //MARK: Virtual Functions
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ViewCellTask", forIndexPath: indexPath) as! ViewCellTask
        cell.setTask(TaskHelper.instance.getTasks()[indexPath.row])
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TaskHelper.instance.getTasks().count
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        openEditView(TaskHelper.instance.getTasks()[indexPath.row])
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action: UITableViewRowAction, indexPath: NSIndexPath!) -> Void in
            
           TaskHelper.instance.removeTask(indexPath.row)
           self.tableView.reloadData()
        }
        
        deleteAction.backgroundColor = UIColor.grayColor()
        
        return [deleteAction]
    }
    
    //MARK: Additional Functions
    
    func openEditView(task: Task?) {
        
        let viewControllerTaskEdit: ViewControllerTaskEdit = self.storyboard?.instantiateViewControllerWithIdentifier("ViewControllerTaskEdit") as! ViewControllerTaskEdit
        viewControllerTaskEdit.task = task
        self.presentViewController(viewControllerTaskEdit, animated: true, completion: nil)
        
    }
    
    func getActionMenuController() -> UIAlertController {
        
        let actionManu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let sortByABCAction = UIAlertAction(title: "Sort by ABC", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            TaskHelper.instance.sortTasks(SortingType.byText, withMain: true)
            self.tableView.reloadData()
        })
        let sortByDateAction = UIAlertAction(title: "Sort by date", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            TaskHelper.instance.sortTasks(SortingType.byDate, withMain: true)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            actionManu.dismissViewControllerAnimated(true, completion: nil)
        })
        
        actionManu.addAction(sortByABCAction)
        actionManu.addAction(sortByDateAction)
        actionManu.addAction(cancelAction)

        return actionManu
    }
    
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Actions
    
    @IBAction func OnAddItemPressed(sender: UIBarButtonItem) {
        
        openEditView(nil)
    }
    
    //MARK: Additional Functions
    

    @IBAction func showActionMenu(sender: UIBarButtonItem) {
        
        
        self.presentViewController(getActionMenuController(), animated: true, completion: nil)
        
    }
    
}