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
    let manager = ManagerData()
    var notificationToken: NotificationToken? = nil
    var weekWeather = WeekWeatherClass()
    
    
    @IBOutlet var datesLabels: [UILabel]!
    @IBOutlet var weatherDayIcons: [UIImageView]!
    @IBOutlet var weatherDayDescriptionLabels: [UILabel]!
    @IBOutlet var temperatureMaxLabels: [UILabel]!
    @IBOutlet var temperatureMinLabels: [UILabel]!
    
    
    
    let city = "Taganrog"
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultValues()
        
//        weekWeatherStruct.updateUI()
        
        view.backgroundColor = Colors.skyBlue
        manager.loadJSON(loadCity: city)
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    

    
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
 

    
}
