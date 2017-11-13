//
//  WeekWeatherStruct.swift
//  Weather.test
//
//  Created by Ковалева on 13.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class WeekWeatherClass: WeekWeatherCityViewController {
    var cityName = ""
    var cityCountry = ""
    
    var firstDayDate = ""
    var firstDayTemperature = 0
    var firstDayTemperatureMin = 0
    var firstDayTemperatureMax = 0
    var firstDayPressure = 0.0
    var firstDayHumidity = 0
    var firstDayWindSpeed = 0.0
    var firstDayWindDegrees = 0.0
    var firstDayWeatherDescription = ""
    var firstDayWeatherIcon = ""
    
    
    var secondDayDate = ""
    var secondDayTemperature = 0
    var secondDayTemperatureMin = 0
    var secondDayTemperatureMax = 0
    var secondDayPressure = 0.0
    var secondDayHumidity = 0
    var secondDayWindSpeed = 0.0
    var secondDayWindDegrees = 0.0
    var secondDayWeatherDescription = ""
    var secondDayWeatherIcon = ""
    
    var thirdDayDate = ""
    var thirdDayTemperature = 0
    var thirdDayTemperatureMin = 0
    var thirdDayTemperatureMax = 0
    var thirdDayPressure = 0.0
    var thirdDayHumidity = 0
    var thirdDayWindSpeed = 0.0
    var thirdDayWindDegrees = 0.0
    var thirdDayWeatherDescription = ""
    var thirdDayWeatherIcon = ""
    
    var fourthDayDate = ""
    var fourthDayTemperature = 0
    var fourthDayTemperatureMin = 0
    var fourthDayTemperatureMax = 0
    var fourthDayPressure = 0.0
    var fourthDayHumidity = 0
    var fourthDayWindSpeed = 0.0
    var fourthDayWindDegrees = 0.0
    var fourthDayWeatherDescription = ""
    var fourthDayWeatherIcon = ""
    
    var fifthDayDate = ""
    var fifthDayTemperature = 0
    var fifthDayTemperatureMin = 0
    var fifthDayTemperatureMax = 0
    var fifthDayPressure = 0.0
    var fifthDayHumidity = 0
    var fifthDayWindSpeed = 0.0
    var fifthDayWindDegrees = 0.0
    var fifthDayWeatherDescription = ""
    var fifthDayWeatherIcon = ""
    
    
    func updateUI() {
        let realm = try! Realm()
        let results = realm.objects(WeekWeather.self)
        
        // Observe Results Notifications
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            //            guard let view = self?.view else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                self?.updateLabelsAndImages()
                
                print("new")
            //                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                self?.updateLabelsAndImages()
                print("update")
                
            case .error(let error):
                print("error")
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    func updateLabelsAndImages() {
        let weekWeather = manager.getWeekWeatherFromDB()
        
        for value in weekWeather {
//            weekWeatherStruct.cityName = value.cityName
//            weekWeatherStruct.cityCountry = value.cityCountry
            
            
            
            
        }
        
//        if cityTemperature > 0 {
//            temperatureValueLabel.text = ("+\(cityTemperature)˚")
//        } else {
//            temperatureValueLabel.text = ("\(cityTemperature)˚")
//        }
//        windSpeedLabel.text = ("\(cityWindSpeed) m/s")
//        
//        pressureLabel.text = ("\(cityPressure) mb")
//        humidityLabel.text = ("\(cityHumidity) %")
//        minTemperatureLabel.text = ("\(cityTemperatureMin)˚")
//        maxTemperatureLabel.text = ("\(cityTemperatureMax)˚")
//        weatherDescriptionLabel.text = cityWeatherDiscription
//        weatherIcon.image = UIImage(named: cityWeatherIcon)
    }
}
