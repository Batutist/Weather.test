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
    
    var dateData: [String] = []
    
    
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
        
        // set background color
        // устанавливаем цвет фона
        view.backgroundColor = Colors.skyBlue
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
        let realm = try! Realm()
        let results = realm.objects(WeekWeather.self)
        
        // Observe Results Notifications
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                
                
                print("new")
            //                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                
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
        let weekWeather = manager.getWeekWeatherFromDB()
        guard   let weekWeatherNoon = weekWeather.first?.tempList.filter("date contains '12:00:00'"),
            let weekWeathermidnight = weekWeather.first?.tempList.filter("date contains '21:00:00'")
            else {return}
        
        let dateFormatter = DateFormatter()
        
        var weekWeatherNoonDateString: String {
            let date = Date(timeIntervalSince1970: (weekWeatherNoon.first?.forecastedTime)!)
            dateFormatter.dateFormat = "dd.MM"
            return dateFormatter.string(from: date as Date)
        }
        var todayString: String {
            let today = NSDate()
            dateFormatter.dateFormat = "dd.MM"
            return dateFormatter.string(from: today as Date)
        }
        
        if weekWeatherNoonDateString == todayString {
            for value in weekWeatherNoon {
                dateData.append(value.date)
                print("Дата: \(dateData)")
            }
        } else {
            print("Tomorrow")
        }
        
        //        let gregorian : NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        //        let weekdayComponent : NSDateComponents = gregorian.components(.weekday, from: today as Date) as NSDateComponents
        //        var currentDay = weekdayComponent.weekday - 1
        
        //        let weekWeatherNoonDateString = dateFormatter.string(from: weekWeatherNoon.first?.date as Date)
        //        weekWeatherNoon.first?.date
    }
    
    func dayOfWeek() {
        
        
    }
}
