//
//  TodayWeatherData.swift
//  Weather.test
//
//  Created by Ковалева on 08.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import  RealmSwift

class TodayWeather: Object {
    
    @objc dynamic var cityName = ""
    @objc dynamic var cityCountry = ""
    @objc dynamic var cityTemperature = 0
    @objc dynamic var cityWindSpeed = 0
    @objc dynamic var cityPressure = 0
    @objc dynamic var cityHumidity = 0
    @objc dynamic var cityTemperatureMin = 0
    @objc dynamic var cityTemperatureMax = 0
    @objc dynamic var cityWeatherDiscription = ""
    @objc dynamic var cityWeatherIcon = ""
    
    
    override static func primaryKey() -> String {
        return "cityName"
    }
}
