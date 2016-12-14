//
//  WeatherManager.swift
//  Task-1
//
//  Created by konstantin on 11/23/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation
import UIKit

public class WeatherLoader {
    
    //MARK: Members
    private static var selfInstance: WeatherLoader?
    
    
    //MARK: Properties
    
    private let weatherSiteAddress = "http://api.openweathermap.org/data/2.5/weather"
    private let apiKey = "75a5517a18cff77cd854cb3c594b1681"
    private let imagesAddress = "http://openweathermap.org/img/w/"
    private var images = [String: UIImage]()
    
    public static var instance: WeatherLoader {
        get {
            if selfInstance == nil {
                selfInstance = WeatherLoader ()
            }
            return selfInstance!
        }
    }
    
    //MARK: Public Functions
    
    public func loadWeatherForCity(city: String, completion: ((weatherData: WeatherData?, error: String?) -> ())) {
        
        loadData("\(weatherSiteAddress)?APPID=\(apiKey)&q=\(city)") { (resultData, errorMessage) -> () in
            guard let responseString = String(data: resultData!, encoding: NSUTF8StringEncoding) else {
                completion(weatherData: nil, error: "Error while receiving data")
                return
            }
            
            if responseString.lowercaseString.containsString("error") {
                completion(weatherData: nil, error: responseString)
                return
            }
            
            guard let weatherData = WeatherJSONParser.fromJSONFormat(responseString) else {
                completion(weatherData: nil, error: "Error while converting the data")
                return
            }
            
            completion(weatherData: weatherData, error: nil)
        }
        
    }
    
    func loadWeatherImage(iconID: String, imageView: UIImageView) {
        
        if let img = images[iconID] {
            imageView.image = img
        } else {
            loadData("\(imagesAddress)\(iconID).png", completion: { (resultData, errorMessage) -> () in
                if errorMessage == nil {
                    let image = UIImage(data: resultData!)
                    self.images[iconID] = image
                    Utilities.updateAssync { () -> () in
                       imageView.image = image
                    }
                }
            })
        }
        
    }
    
    public func loadData(urlString: String, completion: ((resultData: NSData?, errorMessage: String?) -> ())) {
        
        guard let url = NSURL(string: urlString) else {
            completion(resultData: nil, errorMessage: "Error creating URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                completion(resultData: nil, errorMessage: "Error:\n\(error)")
            }
            else {
                completion(resultData: data!, errorMessage: nil)
            }
        })
        dataTask.resume()
        
    }
}