//
//  TodayWeather.swift
//  Weather.test
//
//  Created by Ковалева on 17.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import UIKit

struct TodayWeather {
    
    var cityName: UILabel
    var cityCountry: UILabel
    var cityTemperature: UILabel
    var cityWindSpeed: UILabel
    var cityPressure: UILabel
    var cityHumidity: UILabel
    var cityTemperatureMin: UILabel
    var cityTemperatureMax: UILabel
    var cityWeatherDiscription: UILabel
    var cityWeatherIcon: UIImage
}

extension TodayWeather {
    var cityTemperatureString: String {
        return "\(cityTemperature)˚"
    }
    
    var cityWindSpeedString: String {
        return "\(cityWindSpeed) m/s"
    }
    
    var cityPressureString: String {
        return "\(cityPressure) mb"
    }
    
    var cityHumidityString: String {
        return "\(cityHumidity) %"
    }
    
    var cityTemperatureMinString: String {
        return "\(cityTemperatureMin)˚"
    }
    
    var cityTemperatureMaxString: String {
        return "\(cityTemperatureMax)˚"
    }
}
