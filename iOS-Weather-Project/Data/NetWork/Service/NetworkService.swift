//
//  NetworkService.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 1/21/25.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchLocationWeather(location: String) async throws -> WeatherResponseDTO
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()

    func fetchLocationWeather(location: String) async throws -> WeatherResponseDTO {
        let urlString = "\(AppConfig.BASE_URL)?q=\(location)&appid=\(AppConfig.API_KEY)"
           
           guard let url = URL(string: urlString) else {
               throw NSError(domain: "Invalid URL", code: -1, userInfo: nil)
           }
           
           let (data, response) = try await URLSession.shared.data(from: url)

           guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
               throw NSError(domain: "Invalid response", code: -1, userInfo: nil)
           }

           do {
               let decoder = JSONDecoder()
               let weatherData = try decoder.decode(WeatherResponseDTO.self, from: data)
               return weatherData
           } catch {
               throw error
           }
    }
}
