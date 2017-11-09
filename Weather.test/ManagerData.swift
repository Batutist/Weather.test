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
    
    
    func loadJSON(loadCity: String) -> TodayWeather {
        
        let realm = try! Realm()
        let todayWeather = TodayWeather()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let param =  ["q": loadCity, "units": "metric", "appid": "a541dc378e4c7a2a6008385e46920d75"]
        
        Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                
                todayWeather.cityName = json["name"].stringValue
                todayWeather.cityCountry = json["sys"]["country"].stringValue
                todayWeather.cityTemperature = json["main"]["temp"].intValue
                todayWeather.cityWindSpeed = json["wind"]["speed"].doubleValue
                todayWeather.cityPressure = json["main"]["pressure"].doubleValue
                todayWeather.cityHumidity = json["main"]["humidity"].intValue
                todayWeather.cityTemperatureMin = json["main"]["temp_min"].intValue
                todayWeather.cityTemperatureMax = json["main"]["temp_max"].intValue
                todayWeather.cityWeatherDiscription = json["weather"][0]["main"].stringValue
                todayWeather.cityWeatherIcon = json["weather"][0]["icon"].stringValue
                
                
                try! realm.write {
                    realm.add(todayWeather, update: true)
                }
                print("city\(todayWeather.cityName). country \(todayWeather.cityCountry), temp \(todayWeather.cityTemperature), wind \(todayWeather.cityWindSpeed), press \(todayWeather.cityPressure), humid \(todayWeather.cityHumidity), tempMin \(todayWeather.cityTemperatureMin), temp max \(todayWeather.cityTemperatureMax), desc \(todayWeather.cityWeatherDiscription), icon \(todayWeather.cityWeatherIcon)")
            case .failure(let error):
                print(error)
            }
        }
        return todayWeather
    }
    
    func getTodayWeatherFromDB() -> Results<TodayWeather> {
        let realm = try! Realm()
        let todayWeather = realm.objects(TodayWeather.self)
        return todayWeather
    }
}
