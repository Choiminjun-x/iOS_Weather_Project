//
//  WeatherListRouter.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 3/17/25.
//

import UIKit

protocol WeatherListRoutingLogic {
    var viewController: UIViewController? { get set }
    
    func routeToWeatherDetail(weather: CityWeather)
}

final class WeatherListRouter: WeatherListRoutingLogic {
    weak var viewController: UIViewController?
    
    func routeToWeatherDetail(weather: CityWeather) {
        
    }
}
