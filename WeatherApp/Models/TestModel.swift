//
//  TestModel.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 18.06.2021.
//

import Foundation

struct City {
    let cityName: String
    var weatherData: Weather?
    
    static func getDemoCities() -> [City] {
        let data = [
            City(cityName: "Москва", weatherData: nil),
            City(cityName: "Санкт-Петербург", weatherData: nil),
            City(cityName: "Новосибирск", weatherData: nil)
        ]
        
        return data
    }
        
}

