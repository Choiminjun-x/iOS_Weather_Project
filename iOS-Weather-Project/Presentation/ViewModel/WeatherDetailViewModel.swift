//
//  WeatherDetailViewModel.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 3/17/25.
//

import Foundation
import Combine

protocol WeatherDetailViewModelInput {
    func didSearch() async throws
}

protocol WeatherDetailViewModelOutput {
    var weatherForecast: CurrentValueSubject<CityWeatherForecast?, Never> { get set }
}

protocol WeatherDetailViewModel: WeatherDetailViewModelInput, WeatherDetailViewModelOutput { }

class DefaultWeatherDetailViewModel: WeatherDetailViewModel {
    
    private let useCase: FetchWeatherForecastUseCase
    
    let weather: CityWeather // 주입받은 날씨 데이터
    
    var weatherForecast: CurrentValueSubject<CityWeatherForecast?, Never> = .init(nil)
    
    init(weather: CityWeather, fetchWeatherForecastUseCase: FetchWeatherForecastUseCase) {
        self.weather = weather
        self.useCase = fetchWeatherForecastUseCase
    }
    
    private func load(location: String) async throws {
        let cityWeatherForecast = try await self.useCase.execute(location: location)
        self.weatherForecast.send(cityWeatherForecast)
    }
}

extension DefaultWeatherDetailViewModel {
    func didSearch() async throws {
        try await self.load(location: self.weather.location)
    }
}

