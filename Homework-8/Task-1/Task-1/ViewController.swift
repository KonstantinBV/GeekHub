//
//  ViewController.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

//MARK: ViewController - extension

extension ViewController: UITableViewDataSource, UITableViewDelegate, ToDoListDelegate, ToDoCellDelegate {
    
    //MARK: Virtual Functions
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ViewCellToDo", forIndexPath: indexPath) as! ViewCellToDo
        cell.toDo = ToDoHelper.instanse.getToDoList()[indexPath.row]
        cell.delegate = self
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ToDoHelper.instanse.getToDoList().count
        
    }
    
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
    
    func updateToDoOnDoneChanged(cell: ViewCellToDo) {
        
        guard let indexPath = tableView.indexPathForCell(cell) else {
            showMessage("Error", text: "Data doesn't exist anymore.")
            return
        }        
       
        ToDoHelper.instanse.updateAtIndex(indexPath.row, toDo: cell.toDo!)
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
    
    //MARK: Additional Functions
    
    func openEditView(toDo: ToDo?) {
        
        let viewControllerToDoEdit: ViewControllerToDoEdit = self.storyboard?.instantiateViewControllerWithIdentifier("ViewControllerToDoEdit") as! ViewControllerToDoEdit
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

//MARK: ViewController - class

class ViewController: UIViewController {

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
    
}