//
//  NetworkService.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 1/21/25.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetchLocationWeather(location: String, completion: @escaping (Result<WeatherResponseDTO, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    func fetchLocationWeather(location: String, completion: @escaping (Result<WeatherResponseDTO, Error>) -> Void) {
        let urlString = "\(AppConfig.BASE_URL)?q=\(location)&appid=\(AppConfig.API_KEY)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherResponseDTO.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
