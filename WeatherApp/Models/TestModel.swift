//
//  TestModel.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 18.06.2021.
//

import Foundation

//
struct CityWeather {
    let cityName: String
    let description: String
    let temperature: Float
    let weatherIcon: String
    
    static func getDemoWeather() -> [CityWeather] {
        let data = [
            CityWeather(cityName: "Москва", description: "Ясно", temperature: 29.2, weatherIcon: "01d"),
            CityWeather(cityName: "Санкт-Петербург", description: "Пасмурно", temperature: 22.7, weatherIcon: "02d"),
            CityWeather(cityName: "Нижний Новгород", description: "Облачно", temperature: 28.5, weatherIcon: "03d"),
            CityWeather(cityName: "Новосибирск", description: "Дождь", temperature: 30.0, weatherIcon: "01n"),
            CityWeather(cityName: "Владивосток", description: "Ясно", temperature: 29.1, weatherIcon: "02n")
        ]
        
        return data
    }
}


