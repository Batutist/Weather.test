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
var cityTemperature = 0
var cityWindSpeed = 0.0
var cityPressure = 0.0
var cityHumidity = 0
var cityTemperatureMin = 0
var cityTemperatureMax = 0
var cityWeatherDiscription = ""
var cityWeatherIcon = ""

class TodayWeatherViewController: UIViewController {
    var city = "Taganrog"
    
    @IBOutlet weak var temperatureValueLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.skyBlue
        
        let manager = ManagerData()
        manager.loadJSON(loadCity: city)
     
        let todayWeather = manager.getTodayWeatherFromDB()
        
        for value in todayWeather {
            cityName.append(value.cityName)
            cityCountry.append(value.cityCountry)
            cityTemperature = value.cityTemperature
            cityWindSpeed = value.cityWindSpeed
            cityPressure = value.cityPressure
            cityHumidity = value.cityHumidity
            cityTemperatureMin = value.cityTemperatureMin
            cityTemperatureMax = value.cityTemperatureMax
            cityWeatherDiscription.append(value.cityWeatherDiscription)
            cityWeatherIcon.append(value.cityWeatherIcon)
        }
        
        if cityTemperature > 0 {
            temperatureValueLabel.text = ("+\(cityTemperature)˚")
        } else {
            temperatureValueLabel.text = ("\(cityTemperature)˚")
        }
        windSpeedLabel.text = ("\(cityWindSpeed) m/s")
        
        pressureLabel.text = ("\(cityPressure) mb")
        humidityLabel.text = ("\(cityHumidity) %")
        minTemperatureLabel.text = ("\(cityTemperatureMin)˚")
        maxTemperatureLabel.text = ("\(cityTemperatureMax)˚")
        weatherDescriptionLabel.text = cityWeatherDiscription
        weatherIcon.image = UIImage(named: cityWeatherIcon)
        
    }
}
