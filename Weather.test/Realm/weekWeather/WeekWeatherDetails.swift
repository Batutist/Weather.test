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
    @objc dynamic var date = ""
    @objc dynamic var temperature = 0
    @objc dynamic var temperatureMin = 0
    @objc dynamic var temperatureMax = 0
    @objc dynamic var pressure = 0.0
    @objc dynamic var humidity = 0
    @objc dynamic var windSpeed = 0.0
    @objc dynamic var windDegrees = 0.0
    @objc dynamic var weatherDescription = ""
    @objc dynamic var weatherIcon = ""
}
