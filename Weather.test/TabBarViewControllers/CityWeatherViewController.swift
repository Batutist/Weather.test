//
//  CityWeatherView.swift
//  Weather.test
//
//  Created by Ковалева on 08.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift



var searchCityName = ""
var searchCityCountry = ""
var searchCityTemperature = 0
var searchCityWindSpeed = 0.0
var searchCityPressure = 0.0
var searchCityHumidity = 0
var searchCityTemperatureMin = 0
var searchCityTemperatureMax = 0
var searchCityWeatherDiscription = ""
var searchCityWeatherIcon = ""

class CityWeatherViewController: UIViewController {
    let manager = ManagerData()
    var city = "Birmingham,GB"
    
    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    @IBOutlet weak var cityWeatherIcon: UIImageView!
    @IBOutlet weak var cityWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var cityMaxTemperatureLabel: UILabel!
    @IBOutlet weak var cityMinTemperatureLabel: UILabel!
    @IBOutlet weak var cityWindSpeedLabel: UILabel!
    @IBOutlet weak var cityPressureLabel: UILabel!
    @IBOutlet weak var cityHumidityLabel: UILabel!
    
    @IBAction func citySearchButtonPressed(_ sender: UIButton) {
        if citySearchTextField.text == "" || citySearchTextField.text == nil {
            dontEnterCityName()             /* func with alertController */
        } else {
            manager.loadJSONSearch(city: citySearchTextField.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.skyBlue
        
        manager.loadJSONSearch(city: city)
        
        let searchCityWeather = manager.getSearchCityWeatherFromDB()
        
        for value in searchCityWeather {
            searchCityName.append(value.searchCityName)
            searchCityCountry.append(value.searchCityCountry)
            searchCityTemperature = value.searchCityTemperature
            searchCityWindSpeed = value.searchCityWindSpeed
            searchCityPressure = value.searchCityPressure
            searchCityHumidity = value.searchCityHumidity
            searchCityTemperatureMin = value.searchCityTemperatureMin
            searchCityTemperatureMax = value.searchCityTemperatureMax
            searchCityWeatherDiscription = value.searchCityWeatherDiscription
            searchCityWeatherIcon.append(value.searchCityWeatherIcon)
        }
        
        cityTemperatureLabel.text = ("\(searchCityTemperature)")
        cityWeatherIcon.image = UIImage(named: searchCityWeatherIcon)
        cityWeatherDescriptionLabel.text = searchCityWeatherDiscription
        cityMaxTemperatureLabel.text = ("\(searchCityTemperatureMax)")
        cityMinTemperatureLabel.text = ("\(searchCityTemperatureMin)")
        cityWindSpeedLabel.text = ("\(searchCityWindSpeed)")
        cityPressureLabel.text = ("\(searchCityPressure)")
        cityHumidityLabel.text = ("\(searchCityHumidity)")
    }
    
    
    func dontEnterCityName() {
        let alertController = UIAlertController(title: "Ошибка", message: "Вы не ввели имя города.", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OK)
        present(alertController, animated: true, completion: nil)
    }
}
