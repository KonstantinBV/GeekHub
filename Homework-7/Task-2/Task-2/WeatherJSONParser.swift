//
//  WeatherJSONParser.swift
//  Task-1
//
//  Created by konstantin on 11/30/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public class WeatherJSONParser {
    
    public static func fromJSONFormat(jsonString: String) -> WeatherData? {
        if !jsonString.isEmpty {
            do {
                let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
                guard let jsonDictionary: NSDictionary = jsonObject as? NSDictionary else {
                    
                    return nil
                }
                
                var weatherData = WeatherData()
                weatherData.coord.lat = jsonDictionary["coord"]?["lat"]
                weatherData.coord.lon = jsonDictionary["coord"]?["lon"]
                weatherData.base = jsonDictionary["base"]
                weatherData.name = jsonDictionary["name"]
                weatherData.main.temp = jsonDictionary["main"]?["temp"]
                weatherData.main.pressure = jsonDictionary["main"]?["pressure"]
                weatherData.main.humidity = jsonDictionary["main"]?["humidity"]
                weatherData.main.temp_max = jsonDictionary["main"]?["temp_max"]
                weatherData.main.temp_min = jsonDictionary["main"]?["temp_min"]
                weatherData.dt = jsonDictionary["dt"]
                weatherData.clouds.all = jsonDictionary["clouds"]?["all"]
                weatherData.cod = jsonDictionary["cod"]
                weatherData.sys.id = jsonDictionary["sys"]?["id"]
                weatherData.sys.message = jsonDictionary["sys"]?["message"]
                weatherData.sys.country = jsonDictionary["sys"]?["country"]
                weatherData.sys.sunrise = jsonDictionary["sys"]?["sunrise"]
                weatherData.sys.sunset = jsonDictionary["sys"]?["sunset"]
                weatherData.sys.type = jsonDictionary["sys"]?["type"]
                for weatherArrItem in jsonDictionary["weather"] as! NSArray {
                    let  weatherDict = weatherArrItem as! NSDictionary
                    var weather = Weather()
                    weather.id = weatherDict["id"]
                    weather.main = weatherDict["main"]
                    weather.description = weatherDict["description"]
                    weather.icon = weatherDict["icon"]
                    weatherData.weather.append(weather)
                }
              
                weatherData.wind.deg = jsonDictionary["wind"]?["deg"]
                weatherData.wind.speed = jsonDictionary["wind"]?["speed"]
                
                return weatherData
                
            } catch {
                return nil
            }
        }
        return nil
    }

    public static func getStringFromNSData(data: NSData?) -> String {
        if let str = String(data: data!, encoding: NSUTF8StringEncoding) {
            return str
        }
        return ""
    }
    
    public static func convertObjectToJSONData(data:AnyObject) -> NSData? {
        
        do {
            let newData = try NSJSONSerialization.dataWithJSONObject(data, options: .PrettyPrinted)
            return newData
        }
        catch {
            print("Ошибка конвертации")
        }
        return nil
    }  
}