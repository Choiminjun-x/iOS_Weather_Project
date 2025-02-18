//
//  AppConfig.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 1/21/25.
//

import Foundation

enum AppConfig  {
    
    enum Environment: String { case Dev, Real }
    static let environment: Environment = Environment(rawValue: Bundle.main.infoDictionary!["ConfigEnvironment"] as! String)!
    static let displayName: String = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
    
    private static let config: [AnyHashable:Any] = {
        let path = Bundle.main.path(forResource: "Config", ofType: "plist")!
        let config = NSDictionary(contentsOfFile: path)!
        return config as! [AnyHashable:Any]
    }()
    private static func info(_ environment: Environment, key: String) -> Any {
        (Self.config[environment.rawValue] as! [AnyHashable:Any])[key]!
    }
    private static func infoCommon(key: String) -> Any {
        (Self.config["Common"] as! [AnyHashable:Any])[key]!
    }
    
    static let API_KEY = infoCommon(key: "API_KEY") as! String
    static let BASE_URL = infoCommon(key: "BASE_URL") as! String
}
