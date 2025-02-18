//
//  Sets.swift
//  iOS-Weather-Project
//
//  Created by 최민준 on 1/20/25.
//

import Foundation

public protocol Sets {}

extension Sets where Self: Any {
    @discardableResult
    public func `do`(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
