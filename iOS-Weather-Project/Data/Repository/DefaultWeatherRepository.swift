//
//  DefaultWeatherRepository.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 1/21/25.
//

import Foundation
import Combine

protocol WeatherRepository {
    func fetchLocationWeather(location: String) async throws -> CityWeather
    func fetchLocationWeatherForecast(location: String) async throws -> CityWeatherForecast
}

final class DefaultWeatherRepository: WeatherRepository {
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchLocationWeather(location: String) async throws -> CityWeather {
        let entity = try await self.networkService.fetchLocationWeather(location: location)
        
        return CityWeather(location: entity.name,
                           time: entity.timezone,
                           weather: entity.weather.first?.main ?? "",
                           temp: entity.main.temp.getTempInCelsius(),
                           maxTemp: entity.main.tempMax.getTempInCelsius(),
                           minTemp: entity.main.tempMin.getTempInCelsius())
    }
    
    func fetchLocationWeatherForecast(location: String) async throws -> CityWeatherForecast {
        let entity = try await self.networkService.fetchLocationWeatherForecast(location: location)
        
        return CityWeatherForecast(name: entity.city.name,
                                   sunrise: entity.city.sunrise,
                                   sunset: entity.city.sunset)
    }
}
