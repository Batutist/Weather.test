//
//  WeekWeatherData.swift
//  Weather.test
//
//  Created by Ковалева on 13.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import  RealmSwift

class WeekWeather: Object {
    
    @objc dynamic var cityName = ""
    @objc dynamic var cityCountry = ""
    
    @objc dynamic var firstDayDate = ""
    @objc dynamic var firstDayTemperature = 0
    @objc dynamic var firstDayTemperatureMin = 0
    @objc dynamic var firstDayTemperatureMax = 0
    @objc dynamic var firstDayPressure = 0.0
    @objc dynamic var firstDayHumidity = 0
    @objc dynamic var firstDayWindSpeed = 0.0
    @objc dynamic var firstDayWindDegrees = 0.0
    @objc dynamic var firstDayWeatherDescription = ""
    @objc dynamic var firstDayWeatherIcon = ""
    
    
    @objc dynamic var secondDayDate = ""
    @objc dynamic var secondDayTemperature = 0
    @objc dynamic var secondDayTemperatureMin = 0
    @objc dynamic var secondDayTemperatureMax = 0
    @objc dynamic var secondDayPressure = 0.0
    @objc dynamic var secondDayHumidity = 0
    @objc dynamic var secondDayWindSpeed = 0.0
    @objc dynamic var secondDayWindDegrees = 0.0
    @objc dynamic var secondDayWeatherDescription = ""
    @objc dynamic var secondDayWeatherIcon = ""
    
    @objc dynamic var thirdDayDate = ""
    @objc dynamic var thirdDayTemperature = 0
    @objc dynamic var thirdDayTemperatureMin = 0
    @objc dynamic var thirdDayTemperatureMax = 0
    @objc dynamic var thirdDayPressure = 0.0
    @objc dynamic var thirdDayHumidity = 0
    @objc dynamic var thirdDayWindSpeed = 0.0
    @objc dynamic var thirdDayWindDegrees = 0.0
    @objc dynamic var thirdDayWeatherDescription = ""
    @objc dynamic var thirdDayWeatherIcon = ""
    
    @objc dynamic var fourthDayDate = ""
    @objc dynamic var fourthDayTemperature = 0
    @objc dynamic var fourthDayTemperatureMin = 0
    @objc dynamic var fourthDayTemperatureMax = 0
    @objc dynamic var fourthDayPressure = 0.0
    @objc dynamic var fourthDayHumidity = 0
    @objc dynamic var fourthDayWindSpeed = 0.0
    @objc dynamic var fourthDayWindDegrees = 0.0
    @objc dynamic var fourthDayWeatherDescription = ""
    @objc dynamic var fourthDayWeatherIcon = ""
    
    @objc dynamic var fifthDayDate = ""
    @objc dynamic var fifthDayTemperature = 0
    @objc dynamic var fifthDayTemperatureMin = 0
    @objc dynamic var fifthDayTemperatureMax = 0
    @objc dynamic var fifthDayPressure = 0.0
    @objc dynamic var fifthDayHumidity = 0
    @objc dynamic var fifthDayWindSpeed = 0.0
    @objc dynamic var fifthDayWindDegrees = 0.0
    @objc dynamic var fifthDayWeatherDescription = ""
    @objc dynamic var fifthDayWeatherIcon = ""
    
    
    override static func primaryKey() -> String {
        return "cityName"
    }
}
