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

let  userDefaults  =  UserDefaults.standard

class ManagerData {
    
    func loadJSONSearch(city: String) -> SearchCityWeather {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let param =  ["q": city, "units": "metric", "appid": "0d56898a0da8944be0e2dff08367ac8c"]
        let searchCityWeather = SearchCityWeather()
        
        Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                
                searchCityWeather.searchCityName = json["name"].stringValue
                searchCityWeather.searchCityCountry = json["sys"]["country"].stringValue
                searchCityWeather.searchCityTemperature = json["main"]["temp"].intValue
                searchCityWeather.searchCityWindSpeed = json["wind"]["speed"].doubleValue
                searchCityWeather.searchCityPressure = json["main"]["pressure"].doubleValue
                searchCityWeather.searchCityHumidity = json["main"]["humidity"].intValue
                searchCityWeather.searchCityTemperatureMin = json["main"]["temp_min"].intValue
                searchCityWeather.searchCityTemperatureMax = json["main"]["temp_max"].intValue
                searchCityWeather.searchCityWeatherDiscription = json["weather"][0]["main"].stringValue
                searchCityWeather.searchCityWeatherIcon = json["weather"][0]["icon"].stringValue
                
                
                try! realm.write {
                    realm.add(searchCityWeather, update: true)
                }
                print("load JSONS search: \(searchCityWeather.searchCityName), \(searchCityWeather.searchCityCountry)")
                userDefaults.set( "ok",  forKey:  "loadSearchCity")
                
            case .failure(let error):
                print(error)
            }
        }
        return searchCityWeather
    }
    
    
    
    
    func loadJSON(loadCity: String) {
        
        let realm = try! Realm()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let todayUrl = "https://api.openweathermap.org/data/2.5/weather"
        let weekUrl = "https://api.openweathermap.org/data/2.5/forecast"
        
        let param =  ["q": loadCity, "units": "metric", "appid": "0d56898a0da8944be0e2dff08367ac8c"]
        
        let urlArray = [todayUrl, weekUrl]
        
        for url in urlArray {
            let url = url
            
            let todayWeather = TodayWeather()
            
            
            if url == todayUrl {
                
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
                        
                        userDefaults.set( "ok",  forKey:  "load")
                        
                        print("""
                            hey city\(todayWeather.cityName).
                            country \(todayWeather.cityCountry),
                            temp \(todayWeather.cityTemperature),
                            wind \(todayWeather.cityWindSpeed),
                            press \(todayWeather.cityPressure),
                            humid \(todayWeather.cityHumidity),
                            tempMin \(todayWeather.cityTemperatureMin),
                            temp max \(todayWeather.cityTemperatureMax),
                            desc \(todayWeather.cityWeatherDiscription),
                            icon \(todayWeather.cityWeatherIcon)
                            """)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            } else if url == weekUrl {
                
            }
        }
    }
    
    func getTodayWeatherFromDB() -> Results<TodayWeather> {
        let realm = try! Realm()
        let todayWeather = realm.objects(TodayWeather.self)
        return todayWeather
    }
    
    func getSearchCityWeatherFromDB() -> Results<SearchCityWeather> {
        let realm = try! Realm()
        let searchCityWeather = realm.objects(SearchCityWeather.self)
        print("get from DB: \(searchCityWeather)")
        return searchCityWeather
    }
}
