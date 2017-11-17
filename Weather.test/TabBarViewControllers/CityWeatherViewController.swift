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


// create variables to work with
// создаем переменные для дальнейшего использования
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

class CityWeatherViewController: UIViewController, UITextFieldDelegate {
    //create object of ManagerData
    // создаем объекс класса ManagerData
    let manager = ManagerData()
    // create notification token
    // создаем токен нотификации
    var notificationToken: NotificationToken? = nil
    let city = "Astana"
    // outlets from interface main.Storyboard
    // ссылки на объекты в UI
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
    // func for search button
    // функция для кнопки поиска
    @IBAction func citySearchButtonPressed(_ sender: UIButton) {
        // check citySearchTextField on validation
        // проверяем валидность введеной информации в citySearchTextField
                if citySearchTextField.text == "" || citySearchTextField.text == nil {
                    dontEnterCityName()             /* func with alertController */
                } else {
                    // if everything is ok transfer city name from citySearchTextField to func loadJSONSearch
                    // если все ок, то передаем название города из citySearchTextField в loadJSONSearch функцию
                    let searchCity = citySearchTextField.text!
                    manager.loadJSONSearch(city: searchCity)
                    // call func to update user interface
                    // вызываем функцию для обновления отображаемых данных
                    updateUI()
                }
        // hide keyboard when button is pressed
        // скрываем клавиатуру по нажатию на кнопку поиск
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.citySearchTextField.delegate = self
        // change background color
        // меняем цвет фона
        view.backgroundColor = Colors.skyBlue
        
        // set defaults values for labels while waiting load data
        // устанавливаем дефолтные значения для ярлыков пока идел процесс загрузки данных
        defaultValues()
        
        // load data of city
        // загружаем данные по городу
        manager.loadJSONSearch(city: city)
        
        // call func to update user interface
        // вызываем функцию для обновления отображаемых данных
        updateUI()
    }
    deinit {
        notificationToken?.invalidate()
    }
    
    func touchesBegan(touches: Set<NSObject>,withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            view.endEditing(true)
        }
        super.touchesBegan(touches as! Set<UITouch>, with: event)
    }
    // func use notificationToken to search changes in DB and display them in UI
    // функция использует нотификацию для обнаружения изменений в БД и отображения их в пользовательском интерфейсе
    func updateUI() {
        let realm = try! Realm()
        let results = realm.objects(SearchCityWeather.self)
        
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
    
    // func with alert controller to display if citySearchTextField is empty
    // функция с всплывающей ошибкой в случае пустого citySearchTextField
    func dontEnterCityName() {
        let alertController = UIAlertController(title: "Ошибка", message: "Вы не ввели имя города.", preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OK)
        present(alertController, animated: true, completion: nil)
    }
    
    // func takes values from DB and change IBOtlets in UI
    // функция берет значения из БД и устанавливает их в элементы пользовательского интерфейса
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
        
        citySearchNameLabel.text = "\(searchCityName), \(searchCityCountry)"
        if searchCityTemperature > 0 {
            cityTemperatureLabel.text = ("+\(searchCityTemperature)˚")
        } else {
            cityTemperatureLabel.text = ("\(searchCityTemperature)˚")
        }
        cityWeatherIcon.image = UIImage(named: searchCityWeatherIcon)
        cityWeatherDescriptionLabel.text = searchCityWeatherDiscription
        cityMaxTemperatureLabel.text = ("\(searchCityTemperatureMax)˚")
        cityMinTemperatureLabel.text = ("\(searchCityTemperatureMin)˚")
        cityWindSpeedLabel.text = ("\(searchCityWindSpeed) m/s")
        cityPressureLabel.text = ("\(searchCityPressure) mb")
        cityHumidityLabel.text = ("\(searchCityHumidity) %")
    }
    // func with default values to display while data is loading
    // функция для отображения дефолтных данных пока не прошла загрузка
    func defaultValues() {
        cityTemperatureLabel.text = "--"
        //        cityWeatherIcon.image = UIImage(named: searchCityWeatherIcon)
        cityWeatherDescriptionLabel.text = "..."
        cityMaxTemperatureLabel.text = "--"
        cityMinTemperatureLabel.text = "--"
        cityWindSpeedLabel.text = "--"
        cityPressureLabel.text = "--"
        cityHumidityLabel.text = "--"
    }
    


    
    //--- Вызывается, когда пользователь кликает на view (за пределами textField)--
    // outlets textField и textField2, UITextFieldDelegate
    // и textField.delegate = ... не нужны
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches , with:event)
    }
}



