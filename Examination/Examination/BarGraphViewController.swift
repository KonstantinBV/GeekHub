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
        
        reinitViewsBorders()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initConstraints()
        
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
    
    func initConstraints() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
            self.initConstraint(self.barMonConstraint)
            self.initConstraint(self.barTuesConstraint)
            self.initConstraint(self.barWedConstraint)
            self.initConstraint(self.barThuConstraint)
            self.initConstraint(self.barFriConstraint)
            self.initConstraint(self.barSatConstraint)
            self.initConstraint(self.barSunConstraint)
            self.view.layoutIfNeeded()

        })
        
    }
    
    private func initConstraint(_ constraint: NSLayoutConstraint) {
        
        guard let validIDstring = constraint.identifier else {
            print("Error! Constraint doesn't have valid identifier.")
            return
        }
        
        guard let validID = Int(validIDstring) else {
            print("Error! Constraint doesn't have valid identifier.")
            return
        }
        
        let barButton: UIButton? = findViewByID(scaleView0.subviews, validID, UIButton.self)
        let barToolTip: UILabel? = findViewByID(scaleView0.subviews, validID, UILabel.self)
        
        if barButton != nil && barToolTip != nil {
            
            let validScaleCount = scaleViews.count - 1
            let maxHeight = barButton!.frame.height
            let oneScaleHeight = maxHeight / CGFloat(validScaleCount)
           
            let randomValue = CGFloat(arc4random_uniform(UInt32(maxHeight)))
            barButton!.isHidden = false
            constraint.constant = randomValue
            let toolTipValue = UInt32(oneScaleDisplayHeight*validScaleCount) - UInt32((randomValue/oneScaleHeight)*CGFloat(oneScaleDisplayHeight))
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
