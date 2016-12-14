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
    private var taskManager = TaskManager()
    
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let vcTaskEdit: ViewControllerTaskEdit = segue.destinationViewController as? ViewControllerTaskEdit else {
            return
        }
        vcTaskEdit.task = Task()
    }*/
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskTableViewCell
        cell.setTask(taskManager.getTasks()[indexPath.row])        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskManager.getTasks().count
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let viewController: ViewControllerTaskEdit = storyboard?.instantiateViewControllerWithIdentifier("taskEditView") as! ViewControllerTaskEdit
        viewController.task = taskManager.getTasks()[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: Actions
    
    @IBAction func OnAddNewTaskPressed(sender: UIBarButtonItem) {
        
        taskManager.addTask("ssss")
        
        tableView.reloadData()
    }
    
    


}

