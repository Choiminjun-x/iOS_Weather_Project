//
//  WeatherListUseCase.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 1/20/25.
//

import Foundation

// MARK: 원하는 지역의 날씨 정보를 얻는 것 UseCase
protocol FetchWeatherUseCase {
    func execute(location: String) async throws -> CityWeather
}

final class DefaultFetchWeatherUseCase: FetchWeatherUseCase {
    
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func execute(location: String) async throws -> CityWeather {
        let weather = try await self.repository.fetchLocationWeather(location: location)
        return weather
    }
}
