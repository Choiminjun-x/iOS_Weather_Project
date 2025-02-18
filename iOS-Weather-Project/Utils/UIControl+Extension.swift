//
//  Untitled.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 2/13/25.
//

import UIKit
import Combine

extension UIControl {
    func publisher(for event: UIControl.Event) -> AnyPublisher<Void, Never> {
        return UIControlPublisher(control: self, event: event).eraseToAnyPublisher()
    }
}

// ✅ UIControlPublisher 정의
private class UIControlPublisher: NSObject, Publisher {
    typealias Output = Void
    typealias Failure = Never
    
    private let control: UIControl
    private let event: UIControl.Event
    
    init(control: UIControl, event: UIControl.Event) {
        self.control = control
        self.event = event
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Void == S.Input {
        let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: event)
        subscriber.receive(subscription: subscription)
    }
}

// ✅ UIControlSubscription 정의
private class UIControlSubscription<S: Subscriber>: Subscription where S.Input == Void {
    
    private var subscriber: S?
    private let control: UIControl
    private let event: UIControl.Event
    
    init(subscriber: S, control: UIControl, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        self.event = event
        self.control.addTarget(self, action: #selector(eventHandler), for: event)
    }
    
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        self.control.removeTarget(self, action: #selector(eventHandler), for: event)
        self.subscriber = nil
    }
    
    @objc private func eventHandler() {
        _ = subscriber?.receive(())
    }
}
