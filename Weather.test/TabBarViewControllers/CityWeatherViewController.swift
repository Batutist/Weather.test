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
    
    var notificationToken: NotificationToken? = nil
    var city = "Birmingham,GB"
    
    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var citySearchNameLabel: UILabel!
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
//            searchCityName = citySearchTextField.text!
//            citySearchNameLabel.text = citySearchTextField.text!
//            let searchCityWeather = manager.getSearchCityWeatherFromDB()
//            updateUIWith(searchCityWeather: searchCityWeather)
//
//        }
    }
    let manager = ManagerData()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.loadJSONSearch(city: city)
        let searchCityWeather = manager.getSearchCityWeatherFromDB()
        
        view.backgroundColor = Colors.skyBlue
        
        

        updateUI()
//        updateUIWith(searchCityWeather: searchCityWeather)
//        print("Look here \(searchCityName)")
    }
    
    
    func dontEnterCityName() {
        let alertController = UIAlertController(title: "Ошибка", message: "Вы не ввели имя города.", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OK)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateUIWith(searchCityWeather: Results<SearchCityWeather>) {
        searchCityName = ""
        
        for value in searchCityWeather {
            searchCityName = value.searchCityName
            searchCityCountry = value.searchCityCountry
            searchCityTemperature  = value.searchCityTemperature
            searchCityWindSpeed = value.searchCityWindSpeed
            searchCityPressure = value.searchCityPressure
            searchCityHumidity = value.searchCityHumidity
            searchCityTemperatureMin = value.searchCityTemperatureMin
            searchCityTemperatureMax = value.searchCityTemperatureMax
            searchCityWeatherDiscription = value.searchCityWeatherDiscription
            searchCityWeatherIcon = value.searchCityWeatherIcon
            
            print("update UI with: \(searchCityName), \(searchCityCountry)")
        }
        
        self.citySearchNameLabel.text = ("\(searchCityName), \(searchCityCountry)")
        self.citySearchTextField.placeholder = searchCityName
        self.cityTemperatureLabel.text = ("\(searchCityTemperature)")
        self.cityWeatherIcon.image = UIImage(named: searchCityWeatherIcon)
        self.cityWeatherDescriptionLabel.text = searchCityWeatherDiscription
        self.cityMaxTemperatureLabel.text = "\(searchCityTemperatureMax)"
        self.cityMinTemperatureLabel.text = "\(searchCityTemperatureMin)"
        self.cityWindSpeedLabel.text = "\(searchCityWindSpeed)"
        self.cityPressureLabel.text = "\(searchCityPressure)"
        self.cityHumidityLabel.text = "\(searchCityHumidity)"
        
        print("values of labels: \(String(describing: citySearchNameLabel.text)), \(String(describing: cityTemperatureLabel.text))")
    }
    


    func updateUI() {
        let realm = try! Realm()
        let searchCityWeather = realm.objects(SearchCityWeather.self)
        
        // Observe Results Notifications
        notificationToken = searchCityWeather.observe { [weak self] (changes: RealmCollectionChange) in
            guard let view = self?.view else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                print("new")
//                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                print("update")
//                self?.weatherList = (self?.manager.getWeatherDataFromDB())!
//                tableView.reloadData()
                
            case .error(let error):
                print("error")
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("look on the error \(error)")
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }
}



