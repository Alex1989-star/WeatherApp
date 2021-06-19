//
//  CityTableViewController.swift
//  WeatherApp
//
//  Created by SERGEY VOROBEV on 18.06.2021.
//

import UIKit

enum Identifier: String {
    case cityCell = "cityCell"
    case detailsVC = "detailsVC"
}

class CityTableViewController: UITableViewController {
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var cities: [City]! // массив с моделями городов

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cities = City.getDemoCities()

        configureNavigationBar()
        configureSearchBar()
        configureTableView()
    }
    
    // MARK: - Methods
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addCityButtonTapped))
        
        title = "Выберите город"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск города"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        tableView.rowHeight = 73
    }
    
    @objc private func addCityButtonTapped() {
        let alert = UIAlertController(title: "Введите название города", message: nil, preferredStyle: .alert)
        
        let appendBut = UIAlertAction(title: "Добавить", style: .default) {
            (action) in
//            Получаем текст из TextField
//            let textField = alert.textFields?.first
            
        }
        
        let cancelBut = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(appendBut)
        alert.addAction(cancelBut)
        
        alert.addTextField {(textField) in
            textField.placeholder = "Название города"
        }
        
        present(alert, animated: true)
    }
}

// MARK: - Extensions
extension CityTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cityCell.rawValue, for: indexPath) as! CityTableViewCell
        let cityWeather = cities[indexPath.row]
        
        cell.cityNameLabel.text = cityWeather.cityName
        
        // тут запрашиваем у сервиса погоду для города в списке
        WeatherService.shared.fetchCityWeather(for: cityWeather.cityName) { result, error in
            guard error == nil, let result = result else {
                return
            }
            
            self.cities[indexPath.row].weatherData = result // тут в модель погоды города записывааем полученные от АПИ данные
            
            
            // обновлять UI можно только в главном потоке так как запрос к АПИ происходит асинхронно
            DispatchQueue.main.async {
                guard let cityWeaherData = self.cities[indexPath.row].weatherData else {
                    return
                }
                
                if cityWeaherData.weather.indices.contains(0) {
                    let weather = cityWeaherData.weather[0]
                    
                    cell.weatherDescriptionLabel.text = weather.weatherDescription
                    cell.temperatureLabel.text = String(format: "%.1f", result.main.temp)
                }
              
            }
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(identifier: Identifier.detailsVC.rawValue) as? DetailsViewController else {
            return
        }
        
        detailsVC.city = cities[indexPath.row]
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension CityTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        print("Entered: \(searchText)")
    }
    
    
}


