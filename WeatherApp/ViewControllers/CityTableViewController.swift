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
    private var cities: [CityWeather]!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cities = CityWeather.getDemoWeather()

        configureNavigationBar()
        configureSearchBar()
        configureTableView()
        
        //setupNavigationBar()
        
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
        cell.weatherDescriptionLabel.text = cityWeather.description
        cell.temperatureLabel.text = String(format: "%.1f", cityWeather.temperature)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(identifier: Identifier.detailsVC.rawValue) as? DetailsViewController else {
            return
        }
        
        detailsVC.weather = cities[indexPath.row]
        
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
    
    private func setupNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
    
    
}

