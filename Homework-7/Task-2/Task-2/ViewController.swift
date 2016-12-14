//
//  ViewController.swift
//  Task-2
//
//  Created by konstantin on 12/13/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    private var weatherData: WeatherData?
    
    //MARK Virtual Functions
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        submitButton.layer.cornerRadius = 4
        cityNameTextField.layer.borderWidth = 1
        cityNameTextField.layer.cornerRadius = 4
        cityNameTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let vcWeather: ViewControllerWeatherResult = segue.destinationViewController as? ViewControllerWeatherResult else {
            return
        }
        guard let weather = weatherData else {
            reportOnError("Unexpected error!")
            return
        }
        vcWeather.setWeather(weather)
    }
    
    //MARK: Actions

    @IBAction func onSubmitPressed() {
        
        errorMessageLabel.text = ""
        let city = cityNameTextField.text!
        if city.isEmpty {
            reportOnError("Please enter city name")
        } else {
            changeControlState(true)
            WeatherLoader.loadWeatherForCity(city, completion: onComplited)
        }
    }
    
    //MARK: Private Functions
    
    private func onComplited(weatherData: WeatherData?, error: String?) {
        
        
        guard let weather = weatherData else {
            if error != nil {
                reportOnError(error!)
            } else {
                reportOnError("Unexpected error!")
            }
            changeControlState(false)
            return
        }
        changeControlState(false)
        self.weatherData = weather
        self.performSegueWithIdentifier("showWeatherResult", sender: self)
    }
    
    private func reportOnError(errorMessage: String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                self.errorMessageLabel.text = errorMessage
                self.errorMessageLabel.sizeToFit()
            }
        }
    }
    
    private func changeControlState(isBusy: Bool) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                if isBusy {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
                self.cityNameTextField.enabled = isBusy ? false : true
                self.submitButton.enabled = isBusy ? false : true
                
                self.cityNameTextField.alpha = isBusy ? 0.5 : 1
                self.submitButton.alpha = isBusy ? 0.5 : 1
                
            }
        }
    }
    
}

