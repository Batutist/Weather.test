//
//  WeekWeatherDetails.swift
//  Weather.test
//
//  Created by Ковалева on 17.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import RealmSwift

class WeekWeatherDetails: Object {
    @objc dynamic var forecastedTime = 0.0
    @objc dynamic var date = ""
    @objc dynamic var humidity = 0
    @objc dynamic var pressure = 0.0
    @objc dynamic var temperature = 0
    @objc dynamic var temperatureMax = 0
    @objc dynamic var temperatureMin = 0
    @objc dynamic var weatherDescription = ""
    @objc dynamic var weatherIcon = ""
    @objc dynamic var windSpeed = 0.0
    @objc dynamic var windDegrees = 0.0
    
    override static func primaryKey() -> String {
        return "date"
    }
    
}

extension WeekWeatherDetails {
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: forecastedTime)
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: date as Date)
    }
    
    
    var humidityString: String {
        return "\(humidity)%"
    }
    
    var pressureString: String {
        return "\(pressure)mb"
    }
    
    var temperatureString: String {
        return "\(temperature)˚"
    }
    
    var temperatureMaxString: String {
        return "\(temperatureMax)˚"
    }
    var temperatureMinString: String {
        return "\(temperatureMin)˚"
    }
    
    var windSpeedString: String {
        return "\(windSpeed)m/s"
    }
    
    var windDegreesString: String {
        var direction = ""
        if  (windDegrees >= 0 && windDegrees < 11.25) ||
            (windDegrees >= 348.75 && windDegrees < 359.99) {
            direction = ("N")
        } else if windDegrees >= 11.25 && windDegrees < 33.75 {
            direction = ("NNE")
        } else if windDegrees >= 33.75 && windDegrees < 56.25 {
            direction = ("NE")
        } else if windDegrees >= 56.25 && windDegrees < 78.75 {
            direction = ("ENE")
        } else if windDegrees >= 78.75 && windDegrees < 101.25 {
            direction = ("E")
        } else if windDegrees >= 101.25 && windDegrees < 123.75 {
            direction = ("ESE")
        } else if windDegrees >= 123.75 && windDegrees < 146.25 {
            direction = ("SE")
        } else if windDegrees >= 146.25 && windDegrees < 168.75 {
            direction = ("SSE")
        } else if windDegrees >= 168.75 && windDegrees < 191.25 {
            direction = ("S")
        } else if windDegrees >= 191.25 && windDegrees < 213.75 {
            direction = ("SSW")
        } else if windDegrees >= 213.75 && windDegrees < 236.25 {
            direction = ("SW")
        } else if windDegrees >= 236.25 && windDegrees < 258.75 {
            direction = ("WSW")
        } else if windDegrees >= 258.75 && windDegrees < 281.25 {
            direction = ("W")
        } else if windDegrees >= 281.25 && windDegrees < 303.75 {
            direction = ("WNW")
        } else if windDegrees >= 303.75 && windDegrees < 326.25 {
            direction = ("NW")
        } else if windDegrees >= 325.25 && windDegrees < 348.75 {
            direction = ("NWN")
        }
        return direction
    }
    
    
    
    
}
