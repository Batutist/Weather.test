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
            let weekWeather = WeekWeather()
            
            
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
                Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        
                        weekWeather.cityName = json["city"]["name"].stringValue
                        weekWeather.cityCountry = json["city"]["country"].stringValue
                        
                        weekWeather.firstDayDate = json["list"][0]["dt_txt"].stringValue
                        weekWeather.firstDayTemperature = json["list"][0]["main"]["temp"].intValue
                        weekWeather.firstDayTemperatureMax = json["list"][0]["main"]["temp_max"].intValue
                        weekWeather.firstDayTemperatureMin = json["list"][0]["main"]["temp_min"].intValue
                        weekWeather.firstDayPressure = json["list"][0]["main"]["pressure"].doubleValue
                        weekWeather.firstDayHumidity = json["list"][0]["main"]["humidity"].intValue
                        weekWeather.firstDayWeatherDescription = json["list"][0]["weather"][0]["main"].stringValue
                        weekWeather.firstDayWeatherIcon = json["list"][0]["weather"][0]["icon"].stringValue
                        weekWeather.firstDayWindSpeed = json["list"][0]["wind"]["speed"].doubleValue
                        weekWeather.firstDayWindDegrees = json["list"][0]["wind"]["deg"].doubleValue
                        
                        
                        weekWeather.secondDayDate = json["list"][8]["dt_txt"].stringValue
                        weekWeather.secondDayDate = json["list"][8]["dt_txt"].stringValue
                        weekWeather.secondDayTemperature = json["list"][8]["main"]["temp"].intValue
                        weekWeather.secondDayTemperatureMax = json["list"][8]["main"]["temp_max"].intValue
                        weekWeather.secondDayTemperatureMin = json["list"][8]["main"]["temp_min"].intValue
                        weekWeather.secondDayPressure = json["list"][8]["main"]["pressure"].doubleValue
                        weekWeather.secondDayHumidity = json["list"][8]["main"]["humidity"].intValue
                        weekWeather.secondDayWeatherDescription = json["list"][8]["weather"][0]["main"].stringValue
                        weekWeather.secondDayWeatherIcon = json["list"][8]["weather"][0]["icon"].stringValue
                        weekWeather.secondDayWindSpeed = json["list"][8]["wind"]["speed"].doubleValue
                        weekWeather.secondDayWindDegrees = json["list"][8]["wind"]["deg"].doubleValue
                        
                        weekWeather.thirdDayDate = json["list"][16]["dt_txt"].stringValue
                        weekWeather.thirdDayDate = json["list"][16]["dt_txt"].stringValue
                        weekWeather.thirdDayDate = json["list"][16]["dt_txt"].stringValue
                        weekWeather.thirdDayTemperature = json["list"][16]["main"]["temp"].intValue
                        weekWeather.thirdDayTemperatureMax = json["list"][16]["main"]["temp_max"].intValue
                        weekWeather.thirdDayTemperatureMin = json["list"][16]["main"]["temp_min"].intValue
                        weekWeather.thirdDayPressure = json["list"][16]["main"]["pressure"].doubleValue
                        weekWeather.thirdDayHumidity = json["list"][16]["main"]["humidity"].intValue
                        weekWeather.thirdDayWeatherDescription = json["list"][16]["weather"][0]["main"].stringValue
                        weekWeather.thirdDayWeatherIcon = json["list"][16]["weather"][0]["icon"].stringValue
                        weekWeather.thirdDayWindSpeed = json["list"][16]["wind"]["speed"].doubleValue
                        weekWeather.thirdDayWindDegrees = json["list"][16]["wind"]["deg"].doubleValue
                        
                        weekWeather.fourthDayDate = json["list"][24]["dt_txt"].stringValue
                        weekWeather.fourthDayDate = json["list"][24]["dt_txt"].stringValue
                        weekWeather.fourthDayDate = json["list"][24]["dt_txt"].stringValue
                        weekWeather.fourthDayDate = json["list"][24]["dt_txt"].stringValue
                        weekWeather.fourthDayTemperature = json["list"][24]["main"]["temp"].intValue
                        weekWeather.fourthDayTemperatureMax = json["list"][24]["main"]["temp_max"].intValue
                        weekWeather.fourthDayTemperatureMin = json["list"][24]["main"]["temp_min"].intValue
                        weekWeather.fourthDayPressure = json["list"][24]["main"]["pressure"].doubleValue
                        weekWeather.fourthDayHumidity = json["list"][24]["main"]["humidity"].intValue
                        weekWeather.fourthDayWeatherDescription = json["list"][24]["weather"][0]["main"].stringValue
                        weekWeather.fourthDayWeatherIcon = json["list"][24]["weather"][0]["icon"].stringValue
                        weekWeather.fourthDayWindSpeed = json["list"][24]["wind"]["speed"].doubleValue
                        weekWeather.fourthDayWindDegrees = json["list"][24]["wind"]["deg"].doubleValue
                        
                        weekWeather.fifthDayDate = json["list"][32]["dt_txt"].stringValue
                        weekWeather.fifthDayDate = json["list"][32]["dt_txt"].stringValue
                        weekWeather.fifthDayDate = json["list"][32]["dt_txt"].stringValue
                        weekWeather.fifthDayDate = json["list"][32]["dt_txt"].stringValue
                        weekWeather.fifthDayDate = json["list"][32]["dt_txt"].stringValue
                        weekWeather.fifthDayTemperature = json["list"][32]["main"]["temp"].intValue
                        weekWeather.fifthDayTemperatureMax = json["list"][32]["main"]["temp_max"].intValue
                        weekWeather.fifthDayTemperatureMin = json["list"][32]["main"]["temp_min"].intValue
                        weekWeather.fifthDayPressure = json["list"][32]["main"]["pressure"].doubleValue
                        weekWeather.fifthDayHumidity = json["list"][32]["main"]["humidity"].intValue
                        weekWeather.fifthDayWeatherDescription = json["list"][32]["weather"][0]["main"].stringValue
                        weekWeather.fifthDayWeatherIcon = json["list"][32]["weather"][0]["icon"].stringValue
                        weekWeather.fifthDayWindSpeed = json["list"][32]["wind"]["speed"].doubleValue
                        weekWeather.fifthDayWindDegrees = json["list"][32]["wind"]["deg"].doubleValue
                        
                        
                        print("Look week weather date: \(weekWeather.firstDayDate), \(weekWeather.secondDayDate), \(weekWeather.thirdDayDate), \(weekWeather.fourthDayDate), \(weekWeather.fifthDayDate)")
                        
                        try! realm.write {
                            realm.add(weekWeather, update: true)
                        }
                        
                        userDefaults.set( "ok",  forKey:  "load")
                        
                    case .failure(let error):
                        print(error)
                    }
                }
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
