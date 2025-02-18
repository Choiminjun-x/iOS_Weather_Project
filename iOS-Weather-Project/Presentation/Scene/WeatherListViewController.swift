//
//  WeatherListViewController.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 1/20/25.
//

import UIKit
import Combine

class WeatherListViewController: UIViewController {
    
    init(viewModel: WeatherListViewModel) {
          self.viewModel = viewModel
          super.init(nibName: nil, bundle: nil)
      }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private var viewDisplayLogic: WeatherListViewDisplayLogic { self.view as! WeatherListViewDisplayLogic }
    private var viewEventLogic: WeatherListViewEventLogic { self.view as! WeatherListViewEventLogic }
    
    private var viewModel: WeatherListViewModel
    
    private let defaultLocations = ["seoul", "busan", "daegu", "jeju"]
    
    private var cancellables = Set<AnyCancellable>()
    
    override func loadView() {
        self.view = WeatherListView.create()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewEventLogic.do {
            $0.refreshButtonDidTap.sink {
                self.viewModel.didSearch(locations: self.defaultLocations)
            }.store(in: &cancellables)
        }
        
        self.setEventBindings()
        self.requestPageInfo()
    }
    
    private func requestPageInfo() {
        self.viewModel.didSearch(locations: self.defaultLocations)
    }
    
    private func setEventBindings() {
        self.viewModel.weatherList.sink { weathers in
            self.viewDisplayLogic.displayPageInfo(weathers: weathers)
        }.store(in: &cancellables)
    }
}
