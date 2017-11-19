//
//  SearchCityWeatherData.swift
//  Weather.test
//
//  Created by Ковалева on 09.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import  RealmSwift

// Realm DB class for current weather in the search city

class SearchCityWeather: Object {
    
    @objc dynamic var searchCityName = ""
    @objc dynamic var searchCityCountry = ""
    @objc dynamic var searchCityTemperature = 0
    @objc dynamic var searchCityWindSpeed = 0.0
    @objc dynamic var searchCityPressure = 0.0
    @objc dynamic var searchCityHumidity = 0
    @objc dynamic var searchCityTemperatureMin = 0
    @objc dynamic var searchCityTemperatureMax = 0
    @objc dynamic var searchCityWeatherDiscription = ""
    @objc dynamic var searchCityWeatherIcon = ""
    
    
    override static func primaryKey() -> String {
        return "searchCityName"
    }
}

extension SearchCityWeather {
    
    var searchCityNameAndCountryString: String {
        return("\(searchCityName), \(searchCityCountry)")
    }
    
    var searchCityTemperatureString: String {
        var temperature = ""
        if searchCityTemperature > 0 {
            temperature = ("+\(searchCityTemperature)˚")
        } else {
            temperature = ("\(searchCityTemperature)˚")
        }
        return temperature
    }
    
    var searchCityWindSpeedString: String {
        return "\(searchCityWindSpeed)m/s"
    }
    
    var searchCityPressureString: String {
        return ("\(searchCityPressure)mb")
    }
    
    var searchCityHumidityString: String {
        return ("\(searchCityHumidity)%")
    }
    
    var temperatureMinString: String {
        return ("\(searchCityTemperatureMin)˚")
    }
    
    var temperatureMaxString: String {
        return ("\(searchCityTemperatureMax)˚")
    }
    
    var icon: UIImage {
        return UIImage(named: searchCityWeatherIcon)!
    }
    
}


