//
//  WeatherListTableViewCell.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 1/20/25.
//

import UIKit

class WeatherListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rootView: UIView!
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    private func configure() {
        self.rootView.do {
            $0.layer.cornerRadius = 12
        }
    }
    
    func displayCell(weather: CityWeather?) {
        self.locationNameLabel.text = weather?.location
        self.timeLabel.text = makeTimeZoneToTime(timeZone: weather?.time ?? 0)
        self.weatherLabel.text = weather?.weather
        self.tempLabel.text = "\(weather?.temp ?? 0)˚"
        self.maxMinTempLabel.text = "H:\(weather?.maxTemp ?? 0)˚ L:\(weather?.maxTemp ?? 0)˚"
    }
}
