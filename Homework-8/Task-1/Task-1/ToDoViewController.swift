//
//  ToDoViewController.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit


//MARK: ToDoViewController - class

class ToDoViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!   
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        ToDoHelper.instanse.delegate = self
        
        Utilities.doSomethingAssync { () -> () in
            ToDoHelper.instanse.loadData()
            self.tableView.reloadData()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        ToDoHelper.instanse.saveData()
    }
    
    //MARK: Actions
    
    @IBAction func OnAddItemPressed(sender: UIBarButtonItem) {
        
        openEditView(nil)
    }

    @IBAction func showActionMenu(sender: UIBarButtonItem) {
        
        self.presentViewController(getActionMenuController(), animated: true, completion: nil)
        
    }
    
    @IBAction func OnSwipeRight(sender: UISwipeGestureRecognizer) {
        
        performSegueWithIdentifier("SwipeMenuViewController", sender: nil)
        
    }
    
}

//MARK: ToDoViewController Extensions

//MARK: extension Additional Functions

extension ToDoViewController {

    func openEditView(toDo: ToDo?) {
        
        let viewControllerToDoEdit: ToDoEditViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ToDoEditViewController") as! ToDoEditViewController
        viewControllerToDoEdit.toDo = toDo
        viewControllerToDoEdit.delegate = self
        self.presentViewController(viewControllerToDoEdit, animated: true, completion: nil)
        
    }
    
    func getActionMenuController() -> UIAlertController {
        
        let actionManu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let sortByABCAction = UIAlertAction(title: "Sort by ABC", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            ToDoHelper.instanse.sort(SortingType.byText, withMain: true)
            self.tableView.reloadData()
        })
        let sortByDateAction = UIAlertAction(title: "Sort by date", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            ToDoHelper.instanse.sort(SortingType.byDate, withMain: true)
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


//MARK: extension ToDoListDelegate

extension ToDoViewController: ToDoListDelegate {
    
    func saveItem(toDo: ToDo, isNew: Bool) {
        
        if isNew {
            ToDoHelper.instanse.add(toDo)
        } else {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                showMessage("Error", text: "No selected data.")
                return
            }
            ToDoHelper.instanse.updateAtIndex(indexPath.row, toDo: toDo)
        }
        
        tableView.reloadData()
        
    }
    
    func showMessage(title: String, text: String) {
        
        let messageMenu = UIAlertController(title: title, message: text, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            messageMenu.dismissViewControllerAnimated(true, completion: nil)
        })
        
        messageMenu.addAction(okAction)
        self.presentViewController(messageMenu, animated: true, completion: nil)
        
    }
    
}

//MARK: extension UITableViewDataSource

extension ToDoViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ToDoViewCell", forIndexPath: indexPath) as! ToDoViewCell
        cell.toDo = ToDoHelper.instanse.getToDoList()[indexPath.row]
        cell.delegate = self
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ToDoHelper.instanse.getToDoList().count
        
    }
    
}

//MARK: extension UITableViewDelegate

extension ToDoViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        openEditView(ToDoHelper.instanse.getToDoList()[indexPath.row])
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {
            (action: UITableViewRowAction, indexPath: NSIndexPath!) -> Void in
            
            ToDoHelper.instanse.remove(indexPath.row)
            self.tableView.reloadData()
            
        }
        
        deleteAction.backgroundColor = UIColor.grayColor()
        
        return [deleteAction]
    }
    
}

//MARK: extension ToDoCellDelegate

extension ToDoViewController: ToDoCellDelegate {
    
    func updateToDoOnDoneChanged(cell: ToDoViewCell) {
        
        guard let indexPath = tableView.indexPathForCell(cell) else {
            showMessage("Error", text: "Data doesn't exist anymore.")
            return
        }
        
        ToDoHelper.instanse.updateAtIndex(indexPath.row, toDo: cell.toDo!)
    }
    
}