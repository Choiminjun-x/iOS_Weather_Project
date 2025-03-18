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
    private var router: WeatherListRoutingLogic?
    
    private let defaultLocations = ["seoul", "busan", "daegu", "jeju"]
    
    private var cancellables = Set<AnyCancellable>()
    
    private func setUp() {
        self.router = WeatherListRouter()
        self.router?.viewController = self
    }
    
    override func loadView() {
        self.view = WeatherListView.create()
        self.setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewEventLogic.do {
            $0.refreshButtonDidTap.sink {
                Task {
                    do {
                        try await self.viewModel.didSearch(locations: self.defaultLocations)
                    } catch {
                        print("requestPageInfo() 호출 중 에러 발생")
                    }
                }
            }.store(in: &cancellables)
            
            $0.cellDidTap.sink { weather in
                
            }.store(in: &cancellables)
        }
        
        self.setEventBindings()
        
        // 호출 순서를 보장할 수 있음
        Task {
            do {
                try await self.requestPageInfo()
            } catch {
                print("requestPageInfo() 호출 중 에러 발생")
            }
        }
    }
    
    private func requestPageInfo() async throws {
        try await self.viewModel.didSearch(locations: self.defaultLocations)
    }
    
    private func setEventBindings() {
        self.viewModel.weatherList.sink { weathers in
            self.viewDisplayLogic.displayPageInfo(weathers: weathers)
        }.store(in: &cancellables)
    }
}
