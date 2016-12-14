//
//  WeatherManager.swift
//  Task-1
//
//  Created by konstantin on 11/23/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class WeatherLoader {
    
    //MARK: Properties
    
    private static let weatherSiteAddress = "http://api.openweathermap.org/data/2.5/weather"
    private static let apiKey = "75a5517a18cff77cd854cb3c594b1681"
    public static let imagesAddress = "http://openweathermap.org/img/w/"
    
    //MARK: Public Functions
    
    public static func loadWeatherForCity(city: String, completion: ((weatherData: WeatherData?, error: String?) -> ())) {
        
        guard let url = NSURL(string: "\(weatherSiteAddress)?APPID=\(apiKey)&q=\(city)") else {
            completion(weatherData: nil, error: "Error creating URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                completion(weatherData: nil, error: "Error:\n\(error)")
            }
            else {
                guard let responseString = String(data: data!, encoding: NSUTF8StringEncoding) else {
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
        })
        dataTask.resume()
    }
}