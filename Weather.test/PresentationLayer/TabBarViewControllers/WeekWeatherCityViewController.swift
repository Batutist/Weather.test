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

class WeekWeatherCityViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // object of ManagerData class
    // создаем объект класса ManagerData
    let manager = ManagerData()
    // create notification Token to watch for changes
    // токен для отслеживания изменений
    var notificationToken: NotificationToken? = nil
    
    private var weekWeatherModel = WeekWeatherModel()
    
    // outlets collections from UI
    // коллекции оутлетов пользовательского интерфейса
    @IBOutlet var gradientView: GradientView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    private let city = "Taganrog"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set background color
        // устанавливаем цвет фона
        view.backgroundColor = Color.skyBlue
        
        //        changeLabelsAndImages()
        
        
        // load data of city
        // загружаем данные по городу
        manager.loadJSONWeek(city: city)
        updateUI()
        
        // call func to update user interface
        // вызываем функцию для обновления отображаемых данных
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? WeekWeatherCollectionViewCell else { return defaultCell }
        
        setValuesFor(cell: cell, indexPath: indexPath)
        
        
        return cell
    }
    
    func setValuesFor(cell: WeekWeatherCollectionViewCell, indexPath: IndexPath) {
        

            getDataFromDB()


//        cell.dayOfTheWeekLabel.text = weekWeatherModel.tempList[indexPath.row].dayOfWeek
//        cell.dateLabel.text = weekWeatherModel.tempList[indexPath.row].dateString
//        cell.dayWeatherIcon.image = UIImage(named: weekWeatherModel.tempList[indexPath.row].weatherIcon)
//        cell.dayWeatherDescriptionLabel.text = weekWeatherModel.tempList[indexPath.row].weatherDescription
//        cell.dayWeatherTemperatureLabel.text = weekWeatherModel.tempList[indexPath.row].temperatureMaxString
//        cell.nightWeatherTemperatureLabel.text = weekWeatherModel.tempList[indexPath.row].temperatureMinString
//        cell.nightWeatherIcon.image = UIImage(named: weekWeatherModel.tempList[indexPath.row].nightWeatherIcon)
//        cell.nightWeatherDescriptionLabel.text = weekWeatherModel.tempList[indexPath.row].nightWeatherDescription
//        cell.windDirectionLabel.text = weekWeatherModel.tempList[indexPath.row].windDegreesString
//        cell.windSpeedLabel.text = weekWeatherModel.tempList[indexPath.row].windSpeedString
        
        

        
    }
    
    
    

    
    func checkOutDates(timeIntervalSince1970: Double) -> Bool {
        let dateFormatter = DateFormatter()
        // преобразуем формат даты дня в строку
        var weekWeatherNoonDateString: String {
            let date = Date(timeIntervalSince1970: timeIntervalSince1970)
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
        return weekWeatherNoonDateString == todayString ? true : false
    }
    
    
    func getDataFromDB() {
        // получаем все данные на неделю
        let weekWeather = manager.getWeekWeatherFromDB()
        // получаем данные по дням только на 12:00 и 21:00
        guard let weekWeatherNoon = weekWeather.first?.tempList.filter("date contains '12:00:00'"),
            let weekWeatherMidnight = weekWeather.first?.tempList.filter("date contains '21:00:00'")
            else { return }

        guard let cityName = weekWeather.first?.cityName, let country = weekWeather.first?.cityCountry else { return }

        self.cityNameLabel.text = "\(cityName), \(country) "

        guard let forecastedTime = weekWeatherNoon.first?.forecastedTime else { return }

        if checkOutDates(timeIntervalSince1970: forecastedTime) {
            
            var tmp = WeekWeatherModelDetails()
            for value in weekWeatherNoon {
                tmp.forecastedTime = value.forecastedTime
                tmp.date = value.date
                tmp.humidity = value.humidity
                tmp.pressure = value.pressure
                tmp.temperature = value.temperature
                tmp.temperatureMax = value.temperatureMax
                tmp.weatherDescription = value.weatherDescription
                tmp.weatherIcon = value.weatherIcon
                tmp.windSpeed = value.windSpeed
                tmp.windDegrees = value.windDegrees
                
                weekWeatherModel.tempList.append(tmp)
                print("day weather: \(weekWeatherModel.tempList.count)")
            }
            
            print("Count \(weekWeatherModel.tempList.count)")
            
        } else {
            // weekWeatherNoonDateString != todayString
            guard let currentDayWeather = weekWeather.first?.tempList.first else { return }
            var tmp = WeekWeatherModelDetails()
            tmp.forecastedTime = currentDayWeather.forecastedTime
            tmp.date = currentDayWeather.date
            tmp.humidity = currentDayWeather.humidity
            tmp.pressure = currentDayWeather.pressure
            tmp.temperature = currentDayWeather.temperature
            tmp.temperatureMax = currentDayWeather.temperatureMax
            tmp.weatherDescription = currentDayWeather.weatherDescription
            tmp.weatherIcon = currentDayWeather.weatherIcon
            tmp.windSpeed = currentDayWeather.windSpeed
            tmp.windDegrees = currentDayWeather.windDegrees

            print("tmp is \(tmp)")
            print("Befour append \(weekWeatherModel.tempList.count)")
            weekWeatherModel.tempList = [tmp]
            print("After append \(weekWeatherModel.tempList.count)")
//            guard weekWeatherNoon.count == 5 else { return }
            for value in weekWeatherNoon[0...3] {
                tmp.forecastedTime = value.forecastedTime
                tmp.date = value.date
                tmp.humidity = value.humidity
                tmp.pressure = value.pressure
                tmp.temperature = value.temperature
                tmp.temperatureMax = value.temperatureMax
                tmp.weatherDescription = value.weatherDescription
                tmp.weatherIcon = value.weatherIcon
                tmp.windSpeed = value.windSpeed
                tmp.windDegrees = value.windDegrees

                weekWeatherModel.tempList.append(tmp)
            }
            
            print("Количество \(weekWeatherModel.tempList.count)")
            print(weekWeatherModel.tempList)
            print("Numbers \(weekWeatherNoon.count)")
        }
        // присваиваем ночные показатели в weekWeatherModel.tempList по индексу
        for index in weekWeatherMidnight.indices {
            weekWeatherModel.tempList[index].temperatureMin = weekWeatherMidnight[index].temperatureMin
            weekWeatherModel.tempList[index].nightWeatherDescription = weekWeatherMidnight[index].weatherDescription
            weekWeatherModel.tempList[index].nightWeatherIcon = weekWeatherMidnight[index].weatherIcon
        }
        
    }
    
    // func use notificationToken to search changes in DB and display them in UI
    // функция использует нотификацию для обнаружения изменений в БД и отображения их в пользовательском интерфейсе
    func updateUI() {
        guard let realm = try? Realm() else { return }
        let results = realm.objects(WeekWeather.self)
        
        // Observe Results Notifications
        notificationToken = results.observe {[weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.collectionView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                self?.getDataFromDB()
                collectionView.reloadData()
                
                
                print("new")
            //                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                self?.getDataFromDB()
                collectionView.reloadData()
                print("update")
                
            case .error(let error):
                print("error")
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
            }
        }
    }
    deinit {
        notificationToken?.invalidate()
    }
}







