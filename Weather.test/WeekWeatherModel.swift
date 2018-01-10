//
//  WeekWeatherModel.swift
//  Weather.test
//
//  Created by Sergey on 10.01.2018.
//  Copyright © 2018 Ковалев. All rights reserved.
//

import Foundation

struct WeekWeatherModel {
    var cityName = ""
    var countryName = ""
    var tempList = [WeekWeatherModelDetails]()
    
}
    extension WeekWeatherModel {

        var cityNameAndCountryString: String {
            return("\(cityName), \(countryName)")
        }
    }

