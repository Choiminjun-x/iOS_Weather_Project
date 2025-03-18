//
//  WeatherDetailView.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 3/18/25.
//

import UIKit
import Combine

protocol WeatherDetailViewDisplayLogic where Self: NSObject {
    func displayPageInfo(weathers: [CityWeather]?)
}

protocol WeatherDetailViewEventLogic where Self: NSObject {
    var refreshButtonDidTap: PassthroughSubject<Void, Never> { get }
    var cellDidTap: PassthroughSubject<CityWeather?, Never> { get }
}

class WeatherDetailView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Event Logic
    
    static func create() -> WeatherDetailView {
        let bundle = Bundle(for: WeatherDetailView.self)
        let nib = bundle.loadNibNamed("WeatherDetailView", owner: nil)
        let view = nib?.first
        return view as! WeatherDetailView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    private func configure() {
        
    }
}
