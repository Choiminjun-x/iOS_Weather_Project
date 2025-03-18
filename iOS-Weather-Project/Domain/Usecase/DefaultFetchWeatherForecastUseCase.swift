//
//  DefaultFetchWeatherForecastUseCase.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 3/18/25.
//

import Foundation

// MARK: 원하는 지역의 5일간 날씨 예보 정보를 얻는 것 UseCase
protocol FetchWeatherForecastUseCase {
    func execute(location: String) async throws -> CityWeatherForecast
}

final class DefaultFetchDailyForecastUseCase: FetchWeatherForecastUseCase {
    
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func execute(location: String) async throws -> CityWeatherForecast {
        let weatherForecast = try await self.repository.fetchLocationWeatherForecast(location: location)
        return weatherForecast
    }
}
