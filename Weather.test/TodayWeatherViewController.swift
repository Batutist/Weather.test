//
//  TodayWeatherView.swift
//  Weather.test
//
//  Created by Ковалева on 07.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

let realm = try! Realm()

var cityName = ""
var cityCountry = ""
var cityTemperature = ""
var cityWindSpeed = ""
var cityPressure = ""
var cityHumidity = ""
var cityTemperatureMin = ""
var cityTemperatureMax = ""
var cityWeatherDiscription = ""
var cityWeatherIcon = ""

class TodayWeatherViewController: UIViewController {
    @IBOutlet weak var temperatureValueLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    let manager = ManagerData()
    var city = "Taganrog"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.skyBlue
        manager.loadJSON(loadCity: city)
        
        let todayWeather = manager.getTodayWeatherFromDB()
        
        for value in todayWeather {
            cityName.append(value.cityName)
            cityCountry.append(value.cityCountry)
            cityTemperature.append(value.cityTemperature)
            cityWindSpeed.append(value.cityWindSpeed)
            cityPressure.append(value.cityPressure)
            cityHumidity.append(value.cityHumidity)
            cityTemperatureMin.append(value.cityTemperatureMin)
            cityTemperatureMax.append(value.cityTemperatureMax)
            cityWeatherDiscription.append(value.city)
            cityWeatherIcon.append(value)
        }
    }
    
}
