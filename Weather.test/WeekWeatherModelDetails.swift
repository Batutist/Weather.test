//
//  WeekWeatherModelDetails.swift
//  Weather.test
//
//  Created by Sergey on 10.01.2018.
//  Copyright © 2018 Ковалев. All rights reserved.
//

import Foundation

struct WeekWeatherModelDetails {
    
    var forecastedTime = 0.0
    var date = ""
    var humidity = 0
    var pressure = 0.0
    var temperature = 0
    var temperatureMax = 0
    var temperatureMin = 0
    var weatherDescription = ""
    var weatherIcon = ""
    var windSpeed = 0.0
    var windDegrees = 0.0
    var nightWeatherIcon = ""
    var nightWeatherDescription = ""
    
}
extension WeekWeatherModelDetails {
    
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
    
//    var icon: UIImage {
//        if let icon = UIImage(named: weatherIcon) {
//            return icon
//        } else {
//            return UIImage(named: "01d")!
//        }
//    }
    
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
    
    var dayOfWeek: String {
        var dayOfWeekString = ""
        if WeekWeatherDetails.dayOfWeek(forecastedTime: forecastedTime) == 1 {
            dayOfWeekString = ("Mon")
        } else if WeekWeatherDetails.dayOfWeek(forecastedTime: forecastedTime) == 2 {
            dayOfWeekString = ("Tue")
        } else if WeekWeatherDetails.dayOfWeek(forecastedTime: forecastedTime) == 3 {
            dayOfWeekString = ("Wed")
        } else if WeekWeatherDetails.dayOfWeek(forecastedTime: forecastedTime) == 4 {
            dayOfWeekString = ("Thu")
        } else if WeekWeatherDetails.dayOfWeek(forecastedTime: forecastedTime) == 5 {
            dayOfWeekString = ("Fri")
        } else if WeekWeatherDetails.dayOfWeek(forecastedTime: forecastedTime) == 6 {
            dayOfWeekString = ("Sat")
        } else {
            dayOfWeekString = ("Sun")
        }
        
        return dayOfWeekString
    }
    
    
    
    static func dayOfWeek(forecastedTime: Double) -> Int {
        
        let date = Date(timeIntervalSince1970: forecastedTime)
        
        let gregorian : NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let weekdayComponent : NSDateComponents = gregorian.components(.weekday, from: date as Date) as NSDateComponents
        
        let currentDay = weekdayComponent.weekday - 1 //адаптируем календарь под отечественный
        return currentDay
    }
    
    
}
