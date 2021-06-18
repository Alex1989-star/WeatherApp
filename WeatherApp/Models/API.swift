//
//  API.swift
//  WeatherApp
//
//  Created by Татьяна Татьяна on 18.06.2021.
//

import Foundation

class WeatherCurrently {
    
    var city: String?
    var tempC: Double?
    var icon: String?
    var textHowWeather: String?
    var isDay: Int? // при 0 ночь при 1 день
    
    init(wetherJson: NSDictionary) {
        let location = wetherJson["location"] as! NSDictionary
        city = location["name"] as! String
        let current = wetherJson["current"] as! NSDictionary
        tempC = current["temp_c"] as! Double
        isDay = current["is_day"] as! Int
        let condition = current["condition"] as! NSDictionary
        icon = condition["icon"] as! String
        textHowWeather = condition["text"] as! String
    }
    
    func weatherInCity(city: String) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=1f71ab5474014f50867131317211806&q=\(city)&aqi=yes"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    let weather = WeatherCurrently(wetherJson: json)
                    print(weather.city!)
                    print(weather.tempC!)
                    print(weather.icon!)
                    print(weather.textHowWeather!)
                    print(weather.isDay!)
                }
                catch let jsonError {
                    print(jsonError)
                }

            }
            task.resume()
    }
}

