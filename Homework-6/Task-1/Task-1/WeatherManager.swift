//
//  WeatherManager.swift
//  Task-1
//
//  Created by konstantin on 11/23/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class WeatherManager {
    
    private var weatherSiteAddress = "http://api.openweathermap.org/data/2.5/weather"
    private var apiKey = "75a5517a18cff77cd854cb3c594b1681"
    
    public func getWeatherForCity(city: String) {
        
        guard let url = NSURL(string: "\(weatherSiteAddress)?APPID=\(apiKey)&q=\(city)") else {
            print("Error while creating URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error:\n\(error)")
            }
            else {
                print("Raw data:\n\(data!)\n")
                let dataString = String(data: data!, encoding: NSUTF8StringEncoding)
                print("Human-readable data:\n\(dataString!)")
            }
        })
        dataTask.resume()
        readLine()
    }
    
}