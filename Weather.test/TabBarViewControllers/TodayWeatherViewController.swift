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
    let manager = ManagerData()
    var notificationToken: NotificationToken? = nil
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
        
        manager.loadJSON(loadCity: city)
        
        updateUI()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    func updateUI() {
        let realm = try! Realm()
        let results = realm.objects(TodayWeather.self)
        
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
        let todayWeather = manager.getTodayWeatherFromDB()
        
        for value in todayWeather {
            cityName = value.cityName
            cityCountry = value.cityCountry
            cityTemperature = value.cityTemperature
            cityWindSpeed = value.cityWindSpeed
            cityPressure = value.cityPressure
            cityHumidity = value.cityHumidity
            cityTemperatureMin = value.cityTemperatureMin
            cityTemperatureMax = value.cityTemperatureMax
            cityWeatherDiscription = value.cityWeatherDiscription
            cityWeatherIcon = value.cityWeatherIcon
            
            print("today view: \(cityName), \(cityTemperature), \(cityWeatherDiscription)")
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
