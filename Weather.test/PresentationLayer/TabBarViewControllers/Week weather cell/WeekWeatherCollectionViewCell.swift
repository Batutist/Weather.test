//
//  WeekWeatherCollectionViewCell.swift
//  Weather.test
//
//  Created by Sergey on 09.01.2018.
//  Copyright © 2018 Ковалев. All rights reserved.
//

import UIKit

class WeekWeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayWeatherIcon: UIImageView!
    @IBOutlet weak var dayWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var dayWeatherTemperatureLabel: UILabel!
    
    @IBOutlet weak var nightWeatherTemperatureLabel: UILabel!
    @IBOutlet weak var nightWeatherIcon: UIImageView!
    @IBOutlet weak var nightWeatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
}
