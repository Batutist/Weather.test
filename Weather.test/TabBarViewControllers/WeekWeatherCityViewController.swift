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
    let city = "Alaska"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.skyBlue
        let manager = ManagerData()
        manager.loadJSON(loadCity: city)
    }
    
}
