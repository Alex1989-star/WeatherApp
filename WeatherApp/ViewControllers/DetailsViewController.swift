//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 18.06.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var city: City? // Модель города
    private var cityWeaher: WeatherElement? // Модель погоды города
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cityDataInitialize()
        
        configureView()
        configureByDay()
    }
    
    // MARK: - Methods
    private func cityDataInitialize() {
        guard let cityWeather = city?.weatherData?.weather,
              cityWeather.indices.contains(0) else {
            return
        }
        
        cityWeaher = cityWeather[0]
    }
    
    private func configureView() {
        
    }
    
    private func configureByDay() {
        guard let cityWeaher = cityWeaher else {
            return
        }
        
        let labels = [cityNameLabel, weatherDescriptionLabel, temperatureLabel]
        let labelTextColor: UIColor?
        
        let weatherIcon = String(cityWeaher.icon.suffix(1))
        
       // if cityWeather.weatherData?.weather.indices.contains(0) {
           // let weatherIcon = String(cityWeather.weatherData.weatherIcon.suffix(1))
       // }
        
        switch weatherIcon {
        case "d":
            view.setGradientBackground(from: UIColor(named: "dayGradientStart")!, to: UIColor(named: "dayGradientEnd")!)
            
            navigationController?.navigationBar.tintColor = UIColor(named: "dayTextColor")
            
            labelTextColor = UIColor(named: "dayTextColor")
        default:
            view.setGradientBackground(from: UIColor(named: "nightGradientStart")!, to: UIColor(named: "nightGradientEnd")!)
            
            navigationController?.navigationBar.tintColor = UIColor(named: "nightTextColor")
            
            labelTextColor = UIColor(named: "nightTextColor")
            break
        }
        
        labels.forEach { label in
            label?.textColor = labelTextColor
        }
        
    }
}
