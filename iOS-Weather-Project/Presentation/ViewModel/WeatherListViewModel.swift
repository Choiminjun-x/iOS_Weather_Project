//
//  WeatherListViewModel.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 1/20/25.
//

import Foundation
import Combine

protocol WeatherListViewModelInput {
    func didSearch(locations: [String])
}

protocol WeatherListViewModelOutput {
    var weatherList: CurrentValueSubject<[CityWeather]?, Never> { get }
    var errors: CurrentValueSubject<String?, Never> { get }
}

protocol WeatherListViewModel: WeatherListViewModelInput, WeatherListViewModelOutput { }


class DefaultWeatherListViewModel: WeatherListViewModel {
    
    // MARK: Dependency
    
    private let useCase: FetchWeatherUseCase
    
    // MARK: Output
    
    var weatherList: CurrentValueSubject<[CityWeather]?, Never> = .init(nil)
    var errors: CurrentValueSubject<String?, Never> = .init(nil)
    
    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.useCase = fetchWeatherUseCase
    }
    
    private func load(locations: [String]) {
        let group = DispatchGroup()
        var weatherList = [CityWeather]()
        var errorList = [Error]()
        
        for location in locations {
            group.enter()
            self.useCase.execute(location: location) { result in
                switch result {
                case .success(let model):
                    weatherList.append(model)
                case .failure(let error):
                    errorList.append(error)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if !errorList.isEmpty {
                self.errors.value = NSLocalizedString("Failed loading data", comment: "")
            } else {
                self.weatherList.value = weatherList
            }
        }
    }
}


extension DefaultWeatherListViewModel {
    
    // MARK: Input
    func didSearch(locations: [String]) {
        self.load(locations: locations)
    }
}
