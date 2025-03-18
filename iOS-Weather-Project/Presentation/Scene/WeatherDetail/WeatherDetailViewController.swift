//
//  WeatherDetailViewController.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 3/17/25.
//

import UIKit
import Combine

class WeatherDetailViewController: UIViewController {
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private var viewDisplayLogic: WeatherDetailViewDisplayLogic { self.view as! WeatherDetailViewDisplayLogic }
    private var viewEventLogic: WeatherDetailViewEventLogic { self.view as! WeatherDetailViewEventLogic }
    
    private var viewModel: WeatherDetailViewModel
    private var router: WeatherDetailRoutingLogic?
    
    private var cancellables = Set<AnyCancellable>()
    
    private func setUp() {
        self.router = WeatherDetailRouter()
        self.router?.viewController = self
    }
    
    override func loadView() {
        self.view = WeatherDetailView.create()
        self.setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func requestPageInfo() async throws {
        try await self.viewModel.didSearch()
    }
}
