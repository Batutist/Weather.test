//
//  CityWeatherView.swift
//  Weather.test
//
//  Created by Ковалева on 08.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import UIKit

class CityWeatherViewController: UIViewController {
    
    @IBOutlet weak var citySearchTextField: UITextField!
    @IBOutlet weak var cityTemperatureLabel: UILabel!
    @IBOutlet weak var cityWeatherIcon: UIImageView!
    @IBOutlet weak var cityWeatherDescriptionLabel: UILabel!
    @IBOutlet weak var cityMaxTemperatureLabel: UILabel!
    @IBOutlet weak var cityMinTemperatureLabel: UILabel!
    @IBOutlet weak var cityWindSpeedLabel: UILabel!
    @IBOutlet weak var cityPressureLabel: UILabel!
    @IBOutlet weak var cityHumidityLabel: UILabel!
    
    
    @IBAction func citySearchButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.skyBlue
    }
    
}
