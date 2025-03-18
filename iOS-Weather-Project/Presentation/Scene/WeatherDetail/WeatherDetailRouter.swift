//
//  WeatherDetailRouter.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 3/17/25.
//

import UIKit

protocol WeatherDetailRoutingLogic {
    var viewController: UIViewController? { get set }
    
//    func routeToWeatherDetail(weather: CityWeather)
}

final class WeatherDetailRouter: WeatherDetailRoutingLogic {
    weak var viewController: UIViewController?
    
//    func routeToWeatherDetail(weather: CityWeather) {
//        
//    }
}
