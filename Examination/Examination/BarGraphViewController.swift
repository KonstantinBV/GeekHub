//
//  ViewController.swift
//  Examination
//
//  Created by konstantin on 4/15/17.
//  Copyright © 2017 konstantin. All rights reserved.
//

import UIKit

class BarGraphViewController: UIViewController {
    
    //MARK: Properties
    
    var scaleViews = [UIView]()
    var barConstraints = [NSLayoutConstraint]()
    let oneScaleDisplayHeight = 10
    
    //MARK: Outlets
    
    //MARK: Bar constraints
    
    @IBOutlet weak var barMonConstraint: NSLayoutConstraint!
    @IBOutlet weak var barTuesConstraint: NSLayoutConstraint!
    @IBOutlet weak var barWedConstraint: NSLayoutConstraint!
    @IBOutlet weak var barThuConstraint: NSLayoutConstraint!
    @IBOutlet weak var barFriConstraint: NSLayoutConstraint!
    @IBOutlet weak var barSatConstraint: NSLayoutConstraint!
    @IBOutlet weak var barSunConstraint: NSLayoutConstraint!
    
    //MARK: Scale Views
    
    @IBOutlet weak var scaleView0: UIView!
    @IBOutlet weak var scaleView10: UIView!
    @IBOutlet weak var scaleView20: UIView!
    @IBOutlet weak var scaleView30: UIView!
    @IBOutlet weak var scaleView40: UIView!
    
    //MARK: Virtual Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scaleViews.append(scaleView0)
        scaleViews.append(scaleView10)
        scaleViews.append(scaleView20)
        scaleViews.append(scaleView30)
        scaleViews.append(scaleView40)
        
        barConstraints.append(barMonConstraint)
        barConstraints.append(barTuesConstraint)
        barConstraints.append(barWedConstraint)
        barConstraints.append(barThuConstraint)
        barConstraints.append(barFriConstraint)
        barConstraints.append(barSatConstraint)
        barConstraints.append(barSunConstraint)
        
        reinitViewsBorders()
        hideBars()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        reinitBars()
        
    }
    
    
    
    //MARK: Actions
    
    @IBAction func onBarClick(_ sender: UIButton) {
        
        for view in scaleView0.subviews {
            
            if !(view is UIButton) && view.tag == sender.tag {
                view.isHidden = !view.isHidden
                return
            }
        }
    }
    
    //MARK: Functions
    
    func findViewByID<T>(_ subViews: [UIView], _ id: Int, _ viewType: T.Type) -> T? {
        
        for subView in subViews {
            
            if subView is T && subView.tag == id {
                return (subView as! T)
            }
            if let validChild = findViewByID(subView.subviews, id, viewType) {
                return validChild
            }
        }
        
        return nil
    }

}

//MARK: Extension - work with bar height
extension BarGraphViewController {
    
    func hideBars() {
        
        for barConstraint in self.barConstraints {
            
            let validID = barConstraint.identifier?.getID()
            if validID == nil || !validID!.isValidID() {
                print("Error. Invalid ID.")
                continue
            }
            
            let barButton = findViewByID(scaleView0.subviews, validID!, UIButton.self)
            barConstraint.constant = (barButton?.frame.height)!
            
        }
        
    }
    
    func reinitBars() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
            for barConstraint in self.barConstraints {
                
                self.reinitBar(barConstraint)
                
            }
            self.view.layoutIfNeeded()

        })
        
    }
    
    private func reinitBar(_ constraint: NSLayoutConstraint) {
        
        let validID = constraint.identifier?.getID()
        if validID == nil || !validID!.isValidID() {
            print("Error. Invalid ID.")
            return
        }
        
        let barButton: UIButton? = findViewByID(scaleView0.subviews, validID!, UIButton.self)
        let barToolTip: UILabel? = findViewByID(scaleView0.subviews, validID!, UILabel.self)
        
        if barButton != nil && barToolTip != nil {
            
            let validScaleCount = scaleViews.count - 1
            let oneScaleHeight = scaleView0.frame.height
            let maxHeight = oneScaleHeight * CGFloat(validScaleCount)
           
            let randomValue = CGFloat(arc4random_uniform(UInt32(maxHeight)))
            let toolTipValue = UInt32(oneScaleDisplayHeight*validScaleCount)
                - UInt32((randomValue/oneScaleHeight)*CGFloat(oneScaleDisplayHeight))
            constraint.constant = randomValue
            barToolTip!.text = "\(toolTipValue)"
        }
    }
    
}

//MARK: Extension - work with view borders
extension BarGraphViewController {
    
    func reinitViewsBorders() {
        
        for view in scaleViews {
            
            initBorder(view)
        }
        
    }
    
    private func initBorder(_ inputView: UIView) {
        
        let border = CALayer()
        border.frame = CGRect(x: 0, y: inputView.layer.frame.height+1, width: inputView.layer.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        inputView.layer.addSublayer(border)
    
    }
    
}
