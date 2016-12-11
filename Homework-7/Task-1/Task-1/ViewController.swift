//
//  ViewController.swift
//  Task-1
//
//  Created by konstantin on 12/11/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var lbMainText: UILabel!
    private var calculator = Calculator()
    
    private var mainTextValue: Double {
        get {
            return Double(lbMainText.text!)!
        }
        set {
            lbMainText.text = "\(newValue)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions

    @IBAction func OnButtonPressed(sender: UIButton) {
        if lbMainText.text!.characters.count < 20 {
            mainTextValue = calculator.getDisplayText(sender.currentTitle!)
        }
    }
    
    @IBAction func OnClearClick(sender: UIButton) {
        calculator.clear()
        mainTextValue = 0
    }
    
    
    @IBAction func OnResultClick(sender: UIButton) {
        mainTextValue = calculator.getResult()
    }
    
    @IBAction func OnPlusMinusPressed(sender: UIButton) {
        mainTextValue = -mainTextValue
    }
    
}

