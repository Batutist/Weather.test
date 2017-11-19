//
//  WeekWeatherData.swift
//  Weather.test
//
//  Created by Ковалева on 13.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import  RealmSwift

// Realm DB class for week city weather

class WeekWeather: Object {
    
    @objc dynamic var cityName = ""
    @objc dynamic var cityCountry = ""
    var tempList = List<WeekWeatherDetails>()
    

    override static func primaryKey() -> String {
        return "cityName"
    }
}

extension WeekWeather {
    
    var cityNameAndCountryString: String {
        return("\(cityName), \(cityCountry)")
    }
    
}
