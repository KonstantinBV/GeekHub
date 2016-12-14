//
//  ViewControllerWeatherResult.swift
//  Task-2
//
//  Created by konstantin on 12/13/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

class ViewControllerWeatherResult: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    
    private var weather: WeatherData? = nil
    @IBOutlet weak var weatherTextView: UITextView!
    @IBOutlet weak var weatherTableView: UITableView!
    private var weatherItems: [Weather] {
        get {
            return weather == nil ? [] : weather!.weather
        }
    }
    
    //MARK: Virtual Functions
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Utilities.updateAssync { () -> () in
            self.weatherTextView.editable = false
            self.weatherTextView.layer.cornerRadius = 4
            self.weatherTextView.layer.borderWidth = 1
            self.weatherTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
            if self.weather != nil {
                let info = self.weather!.getWeatherInfo()
                self.weatherTextView.text = info
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        let weatherItem = weatherItems[indexPath.row]
        cell.textLabel?.text = String(weatherItem.description!)
        if weatherItem.icon != nil {
            WeatherLoader.instance.loadWeatherImage(weatherItem.icon as! String, imageView: cell.imageView!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherItems.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

   //MARK: Public Functions
    
    internal func setWeather(wheatherData: WeatherData) {
        
        weather = wheatherData
        
    }
}
