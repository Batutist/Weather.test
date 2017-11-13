//
//  WeekWeatherCityViewController.swift
//  Weather.test
//
//  Created by Ковалева on 08.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class WeekWeatherCityViewController: UIViewController {
    // object of ManagerData class
    // создаем объект класса ManagerData
    let manager = ManagerData()
    // create notification Token to watch for changes
    // токен для отслеживания изменений
    var notificationToken: NotificationToken? = nil
    
    // variables to work with
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
    
    // outlets collections from UI
    // коллекции оутлетов пользовательского интерфейса
    @IBOutlet var datesLabels: [UILabel]!
    @IBOutlet var weatherDayIcons: [UIImageView]!
    @IBOutlet var weatherDayDescriptionLabels: [UILabel]!
    @IBOutlet var temperatureMaxLabels: [UILabel]!
    @IBOutlet var temperatureMinLabels: [UILabel]!
    
    
    let city = "Taganrog"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set default values for labels before load data finished
        // устанавливает значения по умолчанию на время загрузки данных
        defaultValues()
        // set background color
        // устанавливаем цвет фона
        view.backgroundColor = Colors.skyBlue
        // load data of city
        // загружаем данные по городу
        manager.loadJSON(loadCity: city)
        // call func to update user interface
        // вызываем функцию для обновления отображаемых данных
        updateUI()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    // func set default values for labels
    func defaultValues() {
        var firstDayDateLabel = datesLabels[0].text
        var secondDayDateLabel = datesLabels[1].text
        var thirdDayDateLabel = datesLabels[2].text
        var fourthDayDateLabel = datesLabels[3].text
        var fifthDayDateLabel = datesLabels[4].text
        
        firstDayDateLabel = "01/01"
        secondDayDateLabel = "02/02"
        thirdDayDateLabel = "03/03"
        fourthDayDateLabel = "04/04"
        fifthDayDateLabel = "05/05"
        
        var firstWeatherDayIcon = weatherDayIcons[0].image
        var secondWeatherDayIcon = weatherDayIcons[1].image
        var thirdWeatherDayIcon = weatherDayIcons[2].image
        var fourthWeatherDayIcon = weatherDayIcons[3].image
        var fifthWeatherDayIcon = weatherDayIcons[4].image
        
        
        var firstDayWeatherDescriptionLabel = weatherDayDescriptionLabels[0].text
        var secondDayWeatherDescriptionLabel = weatherDayDescriptionLabels[1].text
        var thirdDayWeatherDescriptionLabel = weatherDayDescriptionLabels[2].text
        var fourthDayWeatherDescriptionLabel = weatherDayDescriptionLabels[3].text
        var fifthDayWeatherDescriptionLabel = weatherDayDescriptionLabels[4].text
        
        firstDayWeatherDescriptionLabel = "Shining"
        secondDayWeatherDescriptionLabel = "Cloudy"
        thirdDayWeatherDescriptionLabel = "Rain"
        fourthDayWeatherDescriptionLabel = "Snow"
        fifthDayWeatherDescriptionLabel = "Cold"
        
        var firstDayTemperatureMaxLabel = temperatureMaxLabels[0].text
        var secondDayTemperatureMaxLabel = temperatureMaxLabels[1].text
        var thirdDayTemperatureMaxLabel = temperatureMaxLabels[2].text
        var fourthDayTemperatureMaxLabel = temperatureMaxLabels[3].text
        var fifthDayTemperatureMaxLabel = temperatureMaxLabels[4].text
        
        firstDayTemperatureMaxLabel = "--"
        secondDayTemperatureMaxLabel = "--"
        thirdDayTemperatureMaxLabel = "--"
        fourthDayTemperatureMaxLabel = "--"
        fifthDayTemperatureMaxLabel = "--"
        
        var firstDayTemperatureMinLabel = temperatureMinLabels[0].text
        var secondDayTemperatureMinLabel = temperatureMinLabels[1].text
        var thirdDayTemperatureMinLabel = temperatureMinLabels[2].text
        var fourthDayTemperatureMinLabel = temperatureMinLabels[3].text
        var fifthDayTemperatureMinLabel = temperatureMinLabels[4].text
        
        firstDayTemperatureMinLabel = "--"
        secondDayTemperatureMinLabel = "--"
        thirdDayTemperatureMinLabel = "--"
        fourthDayTemperatureMinLabel = "--"
        fifthDayTemperatureMinLabel = "--"
    }
    // func use notificationToken to search changes in DB and display them in UI
    // функция использует нотификацию для обнаружения изменений в БД и отображения их в пользовательском интерфейсе
    func updateUI() {
        let realm = try! Realm()
        let results = realm.objects(WeekWeather.self)
        
        // Observe Results Notifications
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
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
    
    // func takes values from DB and change IBOtlets in UI
    // функция берет значения из БД и устанавливает их в элементы пользовательского интерфейса
    func updateLabelsAndImages() {
        // get values from DB
        let weekWeather = manager.getWeekWeatherFromDB()
        
        for value in weekWeather {
            cityName = value.cityName
            cityCountry = value.cityCountry
            
            firstDayDate = value.firstDayDate
            firstDayTemperature = value.firstDayTemperature
            firstDayTemperatureMin = value.firstDayTemperatureMin
            firstDayTemperatureMax = value.firstDayTemperatureMax
            firstDayPressure = value.firstDayPressure
            firstDayHumidity = value.firstDayHumidity
            firstDayWindSpeed = value.firstDayWindSpeed
            firstDayWindDegrees = value.fifthDayWindDegrees
            firstDayWeatherDescription = value.firstDayWeatherDescription
            firstDayWeatherIcon = value.firstDayWeatherIcon
            
            secondDayDate = value.secondDayDate
            secondDayTemperature = value.secondDayTemperature
            secondDayTemperatureMin = value.secondDayTemperatureMin
            secondDayTemperatureMax = value.secondDayTemperatureMax
            secondDayPressure = value.secondDayPressure
            secondDayHumidity = value.secondDayHumidity
            secondDayWindSpeed = value.secondDayWindSpeed
            secondDayWindDegrees = value.secondDayWindDegrees
            secondDayWeatherDescription = value.secondDayWeatherDescription
            secondDayWeatherIcon = value.secondDayWeatherIcon
            
            thirdDayDate = value.thirdDayDate
            thirdDayTemperature = value.thirdDayTemperature
            thirdDayTemperatureMin = value.thirdDayTemperatureMin
            thirdDayTemperatureMax = value.thirdDayTemperatureMax
            thirdDayPressure = value.thirdDayPressure
            thirdDayHumidity = value.thirdDayHumidity
            thirdDayWindSpeed = value.thirdDayWindSpeed
            thirdDayWindDegrees = value.thirdDayWindDegrees
            thirdDayWeatherDescription = value.thirdDayWeatherDescription
            thirdDayWeatherIcon = value.thirdDayWeatherIcon
            
            fourthDayDate = value.fourthDayDate
            fourthDayTemperature = value.fourthDayTemperature
            fourthDayTemperatureMin = value.fourthDayTemperatureMin
            fourthDayTemperatureMax = value.fourthDayTemperatureMax
            fourthDayPressure = value.fourthDayPressure
            fourthDayHumidity = value.fourthDayHumidity
            fourthDayWindSpeed = value.fourthDayWindSpeed
            fourthDayWindDegrees = value.fourthDayWindDegrees
            fourthDayWeatherDescription = value.fourthDayWeatherDescription
            fourthDayWeatherIcon = value.fourthDayWeatherIcon
            
            fifthDayDate = value.fifthDayDate
            fifthDayTemperature = value.fifthDayTemperature
            fifthDayTemperatureMin = value.fifthDayTemperatureMin
            fifthDayTemperatureMax = value.fifthDayTemperatureMax
            fifthDayPressure = value.fifthDayPressure
            fifthDayHumidity = value.fifthDayHumidity
            fifthDayWindSpeed = value.fifthDayWindSpeed
            fifthDayWindDegrees = value.fifthDayWindDegrees
            fifthDayWeatherDescription = value.fifthDayWeatherDescription
            fifthDayWeatherIcon = value.fifthDayWeatherIcon
            print("first day date \(firstDayDate)")
        }
        
        datesLabels[0].text = firstDayDate
        datesLabels[1].text = secondDayDate
        datesLabels[2].text = thirdDayDate
        datesLabels[3].text = fourthDayDate
        datesLabels[4].text = fifthDayDate
        
        
        weatherDayIcons[0].image = UIImage(named: firstDayWeatherIcon)
        weatherDayIcons[1].image = UIImage(named: secondDayWeatherIcon)
        weatherDayIcons[2].image = UIImage(named: thirdDayWeatherIcon)
        weatherDayIcons[3].image = UIImage(named: fourthDayWeatherIcon)
        weatherDayIcons[4].image = UIImage(named: fifthDayWeatherIcon)
        
        weatherDayDescriptionLabels[0].text = firstDayWeatherDescription
        weatherDayDescriptionLabels[1].text = secondDayWeatherDescription
        weatherDayDescriptionLabels[2].text = thirdDayWeatherDescription
        weatherDayDescriptionLabels[3].text = fourthDayWeatherDescription
        weatherDayDescriptionLabels[4].text = fifthDayWeatherDescription
        
        temperatureMaxLabels[0].text = ("\(firstDayTemperatureMax)˚")
        temperatureMaxLabels[1].text = ("\(secondDayTemperatureMax)˚")
        temperatureMaxLabels[2].text = ("\(thirdDayTemperatureMax)˚")
        temperatureMaxLabels[3].text = ("\(fourthDayTemperatureMax)˚")
        temperatureMaxLabels[4].text = ("\(fifthDayTemperatureMax)˚")
        
        temperatureMinLabels[0].text = ("\(firstDayTemperatureMin)˚")
        temperatureMinLabels[1].text = ("\(secondDayTemperatureMin)˚")
        temperatureMinLabels[2].text = ("\(thirdDayTemperatureMin)˚")
        temperatureMinLabels[3].text = ("\(fourthDayTemperatureMin)˚")
        temperatureMinLabels[4].text = ("\(fifthDayTemperatureMin)˚")
        
    }
    
    
    
}
