//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 18.06.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var weather: CityWeather!
    
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
        
        configureView()
        configureByDay()
    }
    
    // MARK: - Methods
    private func configureView() {
        
    }
    
    private func configureByDay() {
        let labels = [cityNameLabel, weatherDescriptionLabel, temperatureLabel]
        let labelTextColor: UIColor?
        let weatherIcon = String(weather.weatherIcon.suffix(1))
        
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
