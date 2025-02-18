//
//  DefaultWeatherRepository.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 1/21/25.
//

import Foundation
import Combine

protocol WeatherRepository {
    func fetchLocationWeather(location: String,
                      completion: @escaping (Result<CityWeather, Error>) -> Void)
}

final class DefaultWeatherRepository: WeatherRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchLocationWeather(location: String, completion: @escaping (Result<CityWeather, any Error>) -> Void) {
        self.networkService.fetchLocationWeather(location: location) { result in
            switch result {
            case .success(let entity):
                let model = CityWeather(location: entity.name,
                                        time: entity.timezone,
                                        weather: entity.weather.first?.main ?? "",
                                        temp: entity.main.temp.getTempInCelsius(),
                                        maxTemp: entity.main.tempMax.getTempInCelsius(),
                                        minTemp: entity.main.tempMin.getTempInCelsius())
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
