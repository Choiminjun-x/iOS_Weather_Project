//
//  WeatherListView.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 1/20/25.
//

import UIKit
import Combine

protocol WeatherListViewDisplayLogic where Self: NSObject {
    func displayPageInfo(weathers: [CityWeather]?)
}

protocol WeatherListViewEventLogic where Self: NSObject {
    var refreshButtonDidTap: PassthroughSubject<Void, Never> { get }
}

class WeatherListView: UIView, WeatherListViewDisplayLogic, WeatherListViewEventLogic {
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var weatherListTableView: UITableView!
    
    private var weathers: [CityWeather]?
    
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK: Event Logic
    
    var refreshButtonDidTap: PassthroughSubject<Void, Never> = .init()
        
    static func create() -> WeatherListView {
        let bundle = Bundle(for: WeatherListView.self)
        let nib = bundle.loadNibNamed("WeatherListView", owner: nil)
        let view = nib?.first
        return view as! WeatherListView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    private func configure() {
        self.weatherListTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UINib(nibName: "WeatherListTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherListTableViewCell")
        }
        
        self.refreshButton.do {
            $0.publisher(for: .touchUpInside)
                .sink { _ in
                    self.refreshButtonDidTap.send(())
                }.store(in: &cancellables)
        }
    }
    
    func displayPageInfo(weathers: [CityWeather]?) {
        self.weathers = weathers
        self.weatherListTableView.reloadData()
    }
}


extension WeatherListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListTableViewCell", for: indexPath) as? WeatherListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.displayCell(weather: self.weathers?[indexPath.row])
        
        return cell
    }
}
