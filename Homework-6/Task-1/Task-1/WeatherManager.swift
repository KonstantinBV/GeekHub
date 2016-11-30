//
//  WeatherManager.swift
//  Task-1
//
//  Created by konstantin on 11/23/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class WeatherManager {
    
    private static let weatherSiteAddress = "http://api.openweathermap.org/data/2.5/weather"
    private static let apiKey = "75a5517a18cff77cd854cb3c594b1681"    
    
    public static func getWeatherInfo() {
        print("Введите название города на английском языке.")
        guard let userInput = readLine() else {
            print("Неверный формат данных.")
            return
        }
        
        getWeatherForCity(userInput) { (result) in
            guard let jsonString = result else {
                print("Ошибка получения данных")
                return
            }
            if let weatherData = WeatherJSONParser.fromJSONFormat(jsonString) {
                weatherData.printInfo()
            } else {
                print("Ошибка конвертации данных")
            }
        }
    }
    
    static func getWeatherForCity(city: String, completion: ((result: String?) -> ())) {
        
        guard let url = NSURL(string: "\(weatherSiteAddress)?APPID=\(apiKey)&q=\(city)") else {
            print("Ошибка создания URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let dataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                print("Ошибка:\n\(error)")
            }
            else {
                completion(result: String(data: data!, encoding: NSUTF8StringEncoding))
            }
        })
        dataTask.resume()
    }
}