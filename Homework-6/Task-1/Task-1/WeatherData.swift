//
//  Weather.swift
//  Task-1
//
//  Created by konstantin on 11/30/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation

public struct Coordinates {
   
    public var lon: AnyObject? = nil
    public var lat: AnyObject? = nil
}

public struct Weather {
    
    public var id: AnyObject? = nil
    public var main: AnyObject? = nil
    public var description: AnyObject? = nil
    public var icon: AnyObject? = nil
}

public struct Main {
    
    public var temp: AnyObject? = nil
    public var pressure: AnyObject? = nil
    public var humidity: AnyObject? = nil
    public var temp_min: AnyObject? = nil
    public var temp_max: AnyObject? = nil
}

public struct Wind {
    
    public var speed: AnyObject? = nil
    public var deg: AnyObject? = nil
}

public struct Clouds {
    
    public var all: AnyObject? = nil
}

public struct Sys {
    
    public var type: AnyObject? = nil
    public var id: AnyObject? = nil
    public var message: AnyObject? = nil
    public var country: AnyObject? = nil
    public var sunrise: AnyObject? = nil
    public var sunset: AnyObject? = nil
}

public struct WeatherData {
    
    public var coord: Coordinates = Coordinates()
    public var weather: Weather = Weather()
    public var main: Main = Main()
    public var wind: Wind = Wind()
    public var clouds: Clouds = Clouds()    
    public var sys: Sys = Sys()
    public var dt: AnyObject? = nil
    public var base: AnyObject? = nil
    public var name: AnyObject? = nil
    public var cod: AnyObject? = nil
    
    public func printInfo() {
        
        print("Погода в городе: \(name!) (долгота: \(coord.lon!), широта: \(coord.lat!))")
       
        if let temperature: Double = main.temp as? Double {
            print("Температура: \(String(format: "%.0f", temperature - 273.15))°C")
        }
        print("Атмосферное давление: \(main.pressure!)")        
        print("Направление ветра: \(wind.deg!)°")
        print("Скорость ветра: \(wind.speed!)")
        print("Влажность воздуха: \(main.humidity!)")
    }
}