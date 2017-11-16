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
// user defaults don't use in my app
let  userDefaults  =  UserDefaults.standard

class ManagerData {
    // func get JSON responce by URL and then try to save to DB file WeekWeatherData
    func loadJSONSearch(city: String) -> SearchCityWeather {
        let realm = try! Realm()
        
        // path to the DB file
        //путь к файлу БД
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        // basic url for get request
        // базовый url для get запроса
        let url = "https://api.openweathermap.org/data/2.5/weather"
        // additional parameters in url request
        // дополнительные параметры в url запросе
        let param =  ["q": city, "units": "metric", "appid": "0d56898a0da8944be0e2dff08367ac8c"]
        // create object of SearchCityWeather class
        // создаем объкт класса SearchCityWeather для дальнейшей записи значений в него
        let searchCityWeather = SearchCityWeather()
        // alamofire request
        Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.error)")
            switch response.result {
            case .success(let value):
                // get JSON value
                // получаем данные JSON
                let json = JSON(value)
                // and save them to searchCityWeather
                // и сохраняем полученные значения в searchCityWeather
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
                
                // try to write values to Realm DB
                // пробуем записать полученные значения в БД
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
    
    
    
    // func get JSON responce by URL and then try to save to DB file TodayWeatherData
    // функция получения JSON ответа по url и дальнейшей попыткой записи в TodayWeatherData
    func loadJSONCity(loadCity: String) {
        
        let realm = try! Realm()
        // path to the DB file
        //путь к файлу БД
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // base urls
        // базовые URLs
        let todayUrl = "https://api.openweathermap.org/data/2.5/weather"
        let weekUrl = "https://api.openweathermap.org/data/2.5/forecast"
        // additional parameters in url request
        // дополнительные параметры в url запросе
        let param =  ["q": loadCity, "units": "metric", "appid": "0d56898a0da8944be0e2dff08367ac8c"]
        let todayWeather = TodayWeatherDB()
        Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // get JSON value
                // получаем данные JSON
                let json = JSON(value)
                
                // and save them to todayWeather
                // и сохраняем полученные значения в todayWeather
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
                
                // try to write values to Realm DB
                // пробуем записать полученные значения в БД
                try! realm.write {
                    realm.add(todayWeather, update: true)
                }
                // don't use in my app
                //                        userDefaults.set( "ok",  forKey:  "load")
                
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
    }
    
    func loadJSONWeek(loadCity: String) {
        
        let realm = try! Realm()
        // path to the DB file
        //путь к файлу БД
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // base url
        // базовый URL
        let weekUrl = "https://api.openweathermap.org/data/2.5/forecast"
        // additional parameters in url request
        // дополнительные параметры в url запросе
        let param =  ["q": loadCity, "units": "metric", "appid": "0d56898a0da8944be0e2dff08367ac8c"]
        let weekWeather = WeekWeather()
        Alamofire.request(url, method: .get, parameters: param).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                // get JSON value
                // получаем данные JSON
                let json = JSON(value)
                
                // and save them to weekWeather
                // и сохраняем полученные значения в weekWeather
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
                
                
                print("Look week weather date: \(weekWeather.firstDayDate), \(weekWeather.secondDayDate), \(weekWeather.thirdDayDate), \(weekWeather.fourthDayDate), \(weekWeather.fifthDayDate)")
                // try to write values to Realm DB
                // пробуем записать полученные значения в БД
                try! realm.write {
                    realm.add(weekWeather, update: true)
                }
                // don't use in my app
                //                        userDefaults.set( "ok",  forKey:  "load")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // func to get data from DB
    func getTodayWeatherFromDB() -> Results<TodayWeatherDB> {
        let realm = try! Realm()
        let todayWeather = realm.objects(TodayWeatherDB.self)
        return todayWeather
    }
    // func to get data from DB
    func getWeekWeatherFromDB() -> Results<WeekWeather> {
        let realm = try! Realm()
        let weekWeather = realm.objects(WeekWeather.self)
        return weekWeather
    }
    // func to get data from DB
    func getSearchCityWeatherFromDB() -> Results<SearchCityWeather> {
        let realm = try! Realm()
        let searchCityWeather = realm.objects(SearchCityWeather.self)
        print("get from DB: \(searchCityWeather)")
        return searchCityWeather
    }
}
