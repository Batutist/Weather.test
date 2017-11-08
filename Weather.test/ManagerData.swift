//
//  ManagerData.swift
//  Weather.test
//
//  Created by Ковалева on 08.11.17.
//  Copyright © 2017 Ковалев. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class ManagerData {
    
    
    func loadJSON() {
        
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let param =  ["q": "Taganrog", "units": "metric", "appid": "a541dc378e4c7a2a6008385e46920d75"]
        
        Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let cityName = json["name"].stringValue
                let cityCountry = json["sys"]["country"].stringValue
                let cityTemperature = json["main"]["temp"].intValue
                let cityWindSpeed = json["wind"]["speed"].intValue
                let cityPressure = json["main"]["pressure"].intValue
                let cityHumidity = json["main"]["humidity"].intValue
                let cityTemperatureMin = json["main"]["temp_min"].intValue
                let cityTemperatureMax = json["main"]["temp_max"].intValue
                let cityWeatherDiscription = json["weather"][0]["main"].stringValue
                let cityWeatherIcon = json["weather"][0]["icon"].stringValue
                
                print("city\(cityName). country \(cityCountry), temp \(cityTemperature), wind \(cityWindSpeed), press \(cityPressure), humid \(cityHumidity), tempMin \(cityTemperatureMin), temp max \(cityTemperatureMax), desc \(cityWeatherDiscription), icon \(cityWeatherIcon)")
            case .failure(let error):
                print(error)
            }
        }
//        let realm = try! Realm()
//        print(Realm.Configuration.defaultConfiguration.fileURL)
//        var onlineWeather: WeatherData = WeatherData()
//        let url = "https://api.openweathermap.org/data/2.5/forecast"
//        let param =  ["q": loadCity, "units": "metric", "appid": "cc43de317c7b45042d6dd7d09ee12d74"]
//        Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
//
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//
//                onlineWeather.cityName = json["city"]["name"].stringValue
//                for (_, subJson) in json["list"] {
//                    var tmp: WeatherDetails = WeatherDetails()
//                    tmp.temp = subJson["main"]["temp"].intValue
//                    tmp.icon = subJson["weather"][0]["icon"].stringValue
//                    tmp.date = subJson["dt_txt"].stringValue
//                    onlineWeather.tempList.append(tmp)
//                }
//                try! realm.write {
//                    realm.add(onlineWeather, update: true)
//                }
//                userDefaults.set( "ok",  forKey:  "load")
//                print(onlineWeather)
//            case .failure(let error):
//                print(error)
//            }
        }
}
