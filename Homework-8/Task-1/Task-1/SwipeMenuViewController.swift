//
//  SwipeMenuViewController.swift
//  Task-1
//
//  Created by konstantin on 12/28/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

class SwipeMenuViewController: UIViewController {
    
    //MARK: Actions
    
    @IBAction func OnSwipeLeft(sender: UISwipeGestureRecognizer) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func OnOpenToDoListPressed() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func OnShowInfoPressed() {
        
        performSegueWithIdentifier("ToDoCopyrightsViewController", sender: nil)
        
    }
    
}
