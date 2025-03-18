//
//  WeatherResponseDTO.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 1/21/25.
//

import Foundation

struct WeatherResponseDTO: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int // 날씨 ID (예: 800 = 맑음)
    let main: String // 날씨 상태 (예: "Clear")
    let description: String // 상세 날씨 설명 (예: "clear sky")
    let icon: String // 날씨 아이콘 코드
}

struct Main: Codable {
    let temp: Double // 현재 온도
    let feelsLike: Double // 체감온도
    let tempMin: Double // 최저 기온
    let tempMax: Double // 최고 기온
    let pressure: Int
    let humidity: Int // 습도
    let seaLevel: Int? // 해수면 기압
    let grndLevel: Int? // 지면 기압
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Wind: Codable {
    let speed: Double // 풍속 (m/s)
    let deg: Int // 풍향 (도)
    let gust: Double? // 돌풍 속도 (옵션)
}

struct Rain: Codable {
    let lastHour: Double
    
    enum CodingKeys: String, CodingKey {
        case lastHour = "1h"
    }
}

struct Clouds: Codable {
    let all: Int // 구름량 (%)
}

struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
