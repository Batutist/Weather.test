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
//    func loadJSON(loadCity: String) ->WeatherData  {
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
//        }
//        return onlineWeather
}
