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

// create realm object

let realm = try! Realm()
let animate = Animate()



class TodayWeatherViewController: UIViewController {
    // object of ManagerData class
    // создаем объект класса ManagerData
    let manager = ManagerData()
    
    // create notification Token to watch for changes
    // токен для отслеживания изменений
    var notificationToken: NotificationToken? = nil
    var city = "Taganrog"
    var colorsArray: [(color1: UIColor, color2: UIColor)] = []
    var currentcolorsArrayIndex = -1
    // outlets from UI
    // оутлеты пользовательского интерфейса
    
    @IBOutlet var gradientView: GradientView!
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
        // set background color
        // устанавливаем цвет фона
        view.backgroundColor = Color.skyBlue
        
        animate.backgroundColor(of: gradientView)
        

        // load data of city
        // загружаем данные по городу
        manager.loadJSON(city: city)
        manager.getTodayWeatherFromDB()
        // call func to update user interface
        // вызываем функцию для обновления отображаемых данных
        updateUI()
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    // func use notificationToken to search changes in DB and display them in UI
    // функция использует нотификацию для обнаружения изменений в БД и отображения их в пользовательском интерфейсе
    func updateUI() {
        guard let realm = try? Realm() else { return }
        let results = realm.objects(TodayWeather.self)
        
        // Observe Results Notifications
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            //            guard let view = self?.view else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                
                self?.updateUIWith()
                
                print("new")
            //                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                
                // func to update labels and images values
                // функция обновления значений ярлыков и картинок
                
                self?.updateUIWith()
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
    
    func updateUIWith() {
        let todayWeather = manager.getTodayWeatherFromDB()
        
        for value in todayWeather {
            self.temperatureValueLabel.text = value.cityTemperatureString
            self.weatherIcon.image = value.icon
            self.weatherDescriptionLabel.text = value.cityWeatherDescriptionString
            self.maxTemperatureLabel.text = value.cityTemperatureMaxString
            self.minTemperatureLabel.text = value.cityTemperatureMinString
            self.windSpeedLabel.text = value.cityWindSpeedString
            self.pressureLabel.text = value.cityPressureString
            self.humidityLabel.text = value.cityHumidityString
            
        }
    }
}
