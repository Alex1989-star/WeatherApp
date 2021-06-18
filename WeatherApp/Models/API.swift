//
//  API.swift
//  WeatherApp
//
//  Created by Татьяна Татьяна on 18.06.2021.
//

import Foundation

func searchBarSearchButtonClicked(searchBar: String) {
        let urlString = "https://api.weatherapi.com/v1/current.json?key=1f71ab5474014f50867131317211806&q=\(searchBar)&aqi=yes"
        let url = URL(string: urlString)
        
        var locationName: String?
        var temperature: Double?
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                if let location = json["location"] {
                    locationName = location["name"] as? String
                    print(locationName)
                }
                if let current = json["current"] {
                    temperature = current["temp_c"] as? Double
                    print(temperature)
                }
            }
            catch let jsonError {
                print(jsonError)
            }

        }
        task.resume()
}

