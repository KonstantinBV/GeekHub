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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    //MARK: Additional Functions
    
    func openEditView(task: Task?) {
        
        let viewControllerTaskEdit: ViewControllerTaskEdit = self.storyboard?.instantiateViewControllerWithIdentifier("ViewControllerTaskEdit") as! ViewControllerTaskEdit
        viewControllerTaskEdit.task = task
        self.presentViewController(viewControllerTaskEdit, animated: true, completion: nil)
        
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
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
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
            optionMenu.dismissViewControllerAnimated(true, completion: nil)
        })
        
        optionMenu.addAction(sortByABCAction)
        optionMenu.addAction(sortByDateAction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
    }
    
}