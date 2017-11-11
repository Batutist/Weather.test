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
    var notificationToken: NotificationToken? = nil
    var city = "Tomsk"
    
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
        //        if citySearchTextField.text == "" || citySearchTextField.text == nil {
        //            dontEnterCityName()             /* func with alertController */
        //        } else {
        //            manager.loadJSONSearch(city: citySearchTextField.text!)
        //        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.skyBlue
        
        manager.loadJSONSearch(city: city)
        
        updateUI()
    }
    
    func updateUI() {
        let realm = try! Realm()
        let results = realm.objects(SearchCityWeather.self)
        
        // Observe Results Notifications
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let view = self?.view else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                self?.updateLabelsAndImages()
                
                print("new")
            //                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                
                self?.updateLabelsAndImages()
                print("update")
                
            case .error(let error):
                print("error")
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    
    
    func dontEnterCityName() {
        let alertController = UIAlertController(title: "Ошибка", message: "Вы не ввели имя города.", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OK)
        present(alertController, animated: true, completion: nil)
    }
    deinit {
        notificationToken?.invalidate()
    }
    
    func updateLabelsAndImages() {
                let searchCityWeather = manager.getSearchCityWeatherFromDB()
        
                for value in searchCityWeather {
                    searchCityName = value.searchCityName
                    searchCityCountry = value.searchCityCountry
                    searchCityTemperature = value.searchCityTemperature
                    searchCityWindSpeed = value.searchCityWindSpeed
                    searchCityPressure = value.searchCityPressure
                    searchCityHumidity = value.searchCityHumidity
                    searchCityTemperatureMin = value.searchCityTemperatureMin
                    searchCityTemperatureMax = value.searchCityTemperatureMax
                    searchCityWeatherDiscription = value.searchCityWeatherDiscription
                    searchCityWeatherIcon = value.searchCityWeatherIcon
        
                    print("for value in: \(searchCityName)")
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
    
    
}
