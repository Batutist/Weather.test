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

class WeekWeatherCityViewController: UIViewController
{
    // object of ManagerData class
    // создаем объект класса ManagerData
    let manager = ManagerData()
    // create notification Token to watch for changes
    // токен для отслеживания изменений
    var notificationToken: NotificationToken? = nil
    
    // variables to work with
    var cityName = ""
    var cityCountry = ""
    
    
    // outlets collections from UI
    // коллекции оутлетов пользовательского интерфейса
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet var dayOfWeekLabels: [UILabel]!
    @IBOutlet var datesLabels: [UILabel]!
    @IBOutlet var weatherDayIcons: [UIImageView]!
    @IBOutlet var weatherDayDescriptionLabels: [UILabel]!
    @IBOutlet var temperatureMaxLabels: [UILabel]!
    @IBOutlet var temperatureMinLabels: [UILabel]!
    @IBOutlet var weatherNightIcons: [UIImageView]!
    @IBOutlet var weatherNightDescriptionLabels: [UILabel]!
    @IBOutlet var windDirectionLabels: [UILabel]!
    @IBOutlet var windSpeedLabels: [UILabel]!
    
    
    let city = "Taganrog"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLabelsAndImages()
        
        
        // set default values for labels before load data finished
        // устанавливает значения по умолчанию на время загрузки данных
        
        // set background color
        // устанавливаем цвет фона
        view.backgroundColor = Color.skyBlue
        // load data of city
        // загружаем данные по городу
        manager.loadJSONWeek(city: city)
        
        // call func to update user interface
        // вызываем функцию для обновления отображаемых данных
        
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    // func use notificationToken to search changes in DB and display them in UI
    // функция использует нотификацию для обнаружения изменений в БД и отображения их в пользовательском интерфейсе
    func updateUI() {
        guard let realm = try? Realm() else { return }
        let results = realm.objects(WeekWeather.self)
        
        // Observe Results Notifications
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                self?.changeLabelsAndImages()
                
                print("new")
            //                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                self?.changeLabelsAndImages()
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
    func changeLabelsAndImages() {
        // получаем все данные на неделю
        let weekWeather = manager.getWeekWeatherFromDB()
        print("-----------------------------")
        print(weekWeather)
        print("-----------------------------")
        // получаем данные по дням только на 12:00 и 21:00
        guard   let weekWeatherNoon = weekWeather.first?.tempList.filter("date contains '12:00:00'"),
            let weekWeatherMidnight = weekWeather.first?.tempList.filter("date contains '21:00:00'")
            else {return}
        
        let dateFormatter = DateFormatter()
        // преобразуем формат даты дня в строку
        var weekWeatherNoonDateString: String {
            let date = Date(timeIntervalSince1970: (weekWeatherNoon.first?.forecastedTime)!)
            dateFormatter.dateFormat = "dd.MM"
            return dateFormatter.string(from: date as Date)
        }
        print(weekWeatherNoonDateString)
        // преобразуем дату на момент запроса в строку
        var todayString: String {
            let today = NSDate()
            dateFormatter.dateFormat = "dd.MM"
            return dateFormatter.string(from: today as Date)
        }
        /*
         если дата в 12:00 совпадает с датой запроса, то
         выводим данные из weekWeatherNoon и weekWeathermidnight
         в ярлыки и картинки
         */
        if weekWeatherNoonDateString == todayString {
            
            cityNameLabel.text = weekWeather.first?.cityNameAndCountryString
            // в цикле по индексу присваиваем значение всем оутлетам
            for index in 0...4 {
                dayOfWeekLabels[index].text = weekWeatherNoon[index].dayOfWeek
                datesLabels[index].text = weekWeatherNoon[index].dateString
                weatherDayIcons[index].image = weekWeatherNoon[index].icon
//                weatherDayIcons[index].image = UIImage(named: weekWeatherNoon[index].weatherIcon)
                weatherDayDescriptionLabels[index].text = weekWeatherNoon[index].weatherDescription
                temperatureMaxLabels[index].text = weekWeatherNoon[index].temperatureMaxString
                temperatureMinLabels[index].text = weekWeatherMidnight[index].temperatureMinString
                weatherNightIcons[index].image = UIImage(named: weekWeatherMidnight[index].weatherIcon)
                weatherNightDescriptionLabels[index].text = weekWeatherMidnight[index].weatherDescription
                windSpeedLabels[index].text = weekWeatherMidnight[index].windSpeedString
                windDirectionLabels[index].text = weekWeatherMidnight[index].windDegreesString
                
            }
            
            /* т.к. сайт предоставляет данные только на 5 дней, то в приложении в эелементах, 
             которые относятся к 6 и 7 дням, просто отображаем данные за 5 день.
             */
            for index in 5...6 {
                dayOfWeekLabels[index].text = weekWeatherNoon[4].dayOfWeek
                datesLabels[index].text = weekWeatherNoon[4].dateString
                weatherDayIcons[index].image = weekWeatherNoon[4].icon
//                weatherDayIcons[index].image = UIImage(named: weekWeatherNoon[4].weatherIcon)
                weatherDayDescriptionLabels[index].text = weekWeatherNoon[4].weatherDescription
                temperatureMaxLabels[index].text = weekWeatherNoon[4].temperatureMaxString
                temperatureMinLabels[index].text = weekWeatherMidnight[4].temperatureMinString
                weatherNightIcons[index].image = UIImage(named: weekWeatherMidnight[4].weatherIcon)
                weatherNightDescriptionLabels[index].text = weekWeatherMidnight[4].weatherDescription
                windSpeedLabels[index].text = weekWeatherMidnight[4].windSpeedString
                windDirectionLabels[index].text = weekWeatherMidnight[4].windDegreesString
            }
            /*
             может произойти так, что запрос по погоде будет происходить после 15:00
             и первый элемент с временем 12:00 будет уже следующим днем, тогда
             для максимальной температуры мы берем значения погоды из первого
             элемента массива weekWeatherNoon[0]
             */
        } else {
            /* Если даты не совпадают, то тогда для элемнтов первого дня 
             (макс температура, дата, день недели, описание дневной погоды & иконка погоды)
             берем из первого элемента массива Templist в weekWeather.
             */
            for value in weekWeather {
//                guard   ((dayOfWeekLabels.first?.text = value.tempList.first?.dayOfWeek) != nil),
//                    ((datesLabels.first?.text = value.tempList.first?.dateString) != nil),
//                    ((weatherDayIcons.first?.image = value.tempList.first?.icon) != nil),
//                    ((weatherDayDescriptionLabels.first?.text = value.tempList.first?.weatherDescription) != nil),
//                    ((temperatureMaxLabels.first?.text = value.tempList.first?.temperatureMaxString) != nil)
//                    else {return}
                //                dayOfWeekLabels.first.text = value.tempList.first?.dayOfWeek
                
                dayOfWeekLabels.first?.text = value.tempList.first?.dayOfWeek
                datesLabels.first?.text = value.tempList.first?.dateString
                weatherDayIcons.first?.image = value.tempList.first?.icon
                weatherDayDescriptionLabels.first?.text = value.tempList.first?.weatherDescription
                temperatureMaxLabels.first?.text = value.tempList.first?.temperatureMaxString
            }
        }
        
        // со 2 по 5 день отображаем данные в UI
        for index in 1...4 {
            dayOfWeekLabels[index].text = weekWeatherNoon[index].dayOfWeek
            datesLabels[index].text = weekWeatherNoon[index].dateString
            weatherDayIcons[index].image = weekWeatherNoon[index].icon
            weatherDayDescriptionLabels[index].text = weekWeatherNoon[index].weatherDescription
            temperatureMaxLabels[index].text = weekWeatherNoon[index].temperatureMaxString
        }
        
        // в цикле по индексу присваиваем значение всем оставшимся оутлетам
        for index in 0...4 {
            // datesLabels[index].text = weekWeatherNoon[index].dateString
            // weatherDayIcons[index].image = UIImage(named: weekWeatherNoon[index].weatherIcon)
            // weatherDayDescriptionLabels[index].text = weekWeatherNoon[index].weatherDescription
            // temperatureMaxLabels[index].text = weekWeatherNoon[index].temperatureMaxString
            temperatureMinLabels[index].text = weekWeatherMidnight[index].temperatureMinString
            weatherNightIcons[index].image = weekWeatherMidnight[index].icon
            weatherNightDescriptionLabels[index].text = weekWeatherMidnight[index].weatherDescription
            windSpeedLabels[index].text = weekWeatherMidnight[index].windSpeedString
            windDirectionLabels[index].text = weekWeatherMidnight[index].windDegreesString
        }
        
        /* т.к. сайт предоставляет данные только на 5 дней, то в приложении в эелементах,
         которые относятся к 6 и 7 дням, просто отображаем данные за 5 день.
         */
        for index in 5...6 {
            dayOfWeekLabels[index].text = weekWeatherNoon[4].dayOfWeek
            datesLabels[index].text = weekWeatherNoon[4].dateString
            weatherDayIcons[index].image = weekWeatherNoon[4].icon
            weatherDayDescriptionLabels[index].text = weekWeatherNoon[4].weatherDescription
            temperatureMaxLabels[index].text = weekWeatherNoon[4].temperatureMaxString
            temperatureMinLabels[index].text = weekWeatherMidnight[4].temperatureMinString
            weatherNightIcons[index].image = UIImage(named: weekWeatherMidnight[4].weatherIcon)
            weatherNightDescriptionLabels[index].text = weekWeatherMidnight[4].weatherDescription
            windSpeedLabels[index].text = weekWeatherMidnight[4].windSpeedString
            windDirectionLabels[index].text = weekWeatherMidnight[4].windDegreesString
        }
    }
}







