//
//  ViewController.swift
//  Task-1
//
//  Created by konstantin on 12/14/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

//MARK: ViewController - extension

extension ViewController {
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        toDoHelper.loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        tableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ViewCellToDo", forIndexPath: indexPath) as! ViewCellToDo
        cell.setItem(toDoHelper.getToDoList()[indexPath.row])
        cell.delegate = self
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoHelper.getToDoList().count
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        openEditView(toDoHelper.getToDoList()[indexPath.row])
        
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {
            (action: UITableViewRowAction, indexPath: NSIndexPath!) -> Void in
            
            self.toDoHelper.remove(indexPath.row)
            self.toDoHelper.saveData()
            self.tableView.reloadData()
        }
        
        deleteAction.backgroundColor = UIColor.grayColor()
        
        return [deleteAction]
    }
    
    func saveItem(toDo: ToDo, isNew: Bool) {
        
        if isNew {
            
            toDoHelper.add(toDo)
            
        }
        toDoHelper.saveData()
        tableView.reloadData()
        
    }
    
    func onDoneSwitched() {
        
        toDoHelper.saveData()
        
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
            self.toDoHelper.sort(SortingType.byText, withMain: true)
            self.tableView.reloadData()
        })
        let sortByDateAction = UIAlertAction(title: "Sort by date", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.toDoHelper.sort(SortingType.byDate, withMain: true)
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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ToDoListDelegate, ToDoCellDelegate {

    //MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var toDoHelper = ToDoHelper()
    
    //MARK: Actions
    
    @IBAction func OnAddItemPressed(sender: UIBarButtonItem) {
        
        openEditView(nil)
    }

    @IBAction func showActionMenu(sender: UIBarButtonItem) {
        
        self.presentViewController(getActionMenuController(), animated: true, completion: nil)
        
    }
    
}