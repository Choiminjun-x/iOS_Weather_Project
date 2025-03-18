//
//  WeatherForecastResponseDTO.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 3/13/25.
//

import Foundation

// 최상위 응답 모델
struct WeatherForecastResponseDTO: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [WeatherData] // 5일간의 날씨 정보
    let city: City // 도시 정보
}

// MARK: - WeatherData

struct WeatherData: Codable {
    let dt: Int // 날짜
    let main: MainWeather // 주요 날씨 정보
    let weather: [Weather] // 날씨 상태 정보
    let clouds: Clouds // 구름 정보
    let wind: Wind // 바람 정보
    let visibility: Int // 가시 거리
    let pop: Double // 강수 확률
    let sys: WeatherListSys // 낮/밤 구분 정보
    let dtTxt: String // 날짜 및 시간
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainWeather

struct MainWeather: Codable {
    let temp: Double // 현재 온도 (Kelvin)
    let feelsLike: Double // 체감 온도 (Kelvin)
    let tempMin: Double // 최저 온도 (Kelvin)
    let tempMax: Double // 최고 온도 (Kelvin)
    let pressure: Int // 기압 (hPa)
    let seaLevel: Int? // 해수면 기압 (hPa)
    let grndLevel: Int? // 지면 기압 (hPa)
    let humidity: Int // 습도 (%)
    let tempKf: Double? // 온도 차이 보정 값
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// 도시 정보
struct City: Codable {
    let id: Int // 도시 ID
    let name: String // 도시 이름
    let coord: Coord // 도시 좌표
    let country: String // 국가 코드 (예: "KR")
    let population: Int? // 인구 (옵션)
    let timezone: Int // 타임존 (초)
    let sunrise: Int // 일출 시간 (Unix Timestamp)
    let sunset: Int // 일몰 시간 (Unix Timestamp)
}


struct WeatherListSys: Codable {
    let pod: String // "d" = 낮, "n" = 밤
}
