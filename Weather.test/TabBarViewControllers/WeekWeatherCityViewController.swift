//
//  WeekWeatherCityViewController.swift
//  Weather.test
//
//  Created by Ковалева on 08.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import UIKit

class WeekWeatherCityViewController: UIViewController {
    
    
    @IBOutlet var datesLabels: [UILabel]!
    @IBOutlet var weatherDayIcons: [UIImageView]!
    @IBOutlet var weatherDayDescriptionLabels: [UILabel]!
    @IBOutlet var temperatureMaxLabels: [UILabel]!
    @IBOutlet var temperatureMinLabels: [UILabel]!
    
    
    
    let city = "Alaska"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.skyBlue
        let manager = ManagerData()
        manager.loadJSON(loadCity: city)
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
    }
    
}
