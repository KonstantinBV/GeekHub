//
//  Weather.swift
//  Task-1
//
//  Created by konstantin on 11/30/16.
//  Copyright © 2016 konstantin. All rights reserved.
//

import Foundation
import UIKit

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
    
    public var coord = Coordinates()
    public var weather = [Weather]()
    public var main = Main()
    public var wind = Wind()
    public var clouds = Clouds()
    public var sys = Sys()
    public var dt: AnyObject? = nil
    public var base: AnyObject? = nil
    public var name: AnyObject? = nil
    public var cod: AnyObject? = nil
    
    public func getWeatherInfo() -> String {
        
        var result = ""
        addParameterToInfo(&result, "The weather in the city: \(name!) (lon: \(coord.lon!), lat: \(coord.lat!))", true)
        if let temperature: Double = main.temp as? Double {
            addParameterToInfo(&result, "Temperature: \(String(format: "%.0f", temperature - 273.15))°C")
        }
        if let temperatureMin: Double = main.temp_min as? Double {
            addParameterToInfo(&result, "Temperature min.: \(String(format: "%.0f", temperatureMin - 273.15))°C")
        }
        if let temperatureMax: Double = main.temp_max as? Double {
            addParameterToInfo(&result, "Temperature max.: \(String(format: "%.0f", temperatureMax - 273.15))°C")
        }
        addParameterToInfo(&result, "Pressure: \(main.pressure!) hpa")
        addParameterToInfo(&result, "Wind speed: \(wind.speed!) m/s")
        return result
    }
    
    private func addParameterToInfo(inout result: String, _ parameter: String, _ isFirstLine: Bool = false) {
        let newLineSign = "\r\n"
        result += "\(isFirstLine ? "" : newLineSign)\(parameter)"
    }
}