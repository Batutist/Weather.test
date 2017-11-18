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
    
    
    // outlets collections from UI
    // коллекции оутлетов пользовательского интерфейса
    
    @IBOutlet weak var cityNameLabel: UILabel!
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
            
            cityNameLabel.text = ("\(weekWeather.first?.cityName), \(weekWeather.first?.cityCountry)")
            // в цикле по индексу присваиваем значение всем оутлетам
            for index in 0...4 {
                datesLabels[index].text = weekWeatherNoon[index].dateString
                weatherDayIcons[index].image = UIImage(named: weekWeatherNoon[index].weatherIcon)
                weatherDayDescriptionLabels[index].text = weekWeatherNoon[index].weatherDescription
                temperatureMaxLabels[index].text = weekWeatherNoon[index].temperatureMaxString
                temperatureMinLabels[index].text = weekWeatherMidnight[index].temperatureMinString
                weatherNightIcons[index].image = UIImage(named: weekWeatherMidnight[index].weatherIcon)
                weatherNightDescriptionLabels[index].text = weekWeatherMidnight[index].weatherDescription
                windSpeedLabels[index].text = weekWeatherMidnight[index].windSpeedString
                windDirectionLabels[index].text = weekWeatherMidnight[index].windDegreesString
                
            }
            
//            @IBOutlet var windDirectionLabels: [UILabel]!
//            @IBOutlet var windSpeedLabels: [UILabel]!
            
            
            
        /*
             может произойти так, что запрос по погоде будет происходить после 15:00
             и первый элемент с временем 12:00 будет уже следующим днем, тогда
             для максимальной температуры мы берем значения погоды из первого
             элемента массива weekWeatherNoon[0]
         */
        } else {

            
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
