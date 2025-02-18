//
//  Double+Extension.swift
//  iOS-Weather-Project
//
//  Created by 최민준(Minjun Choi) on 1/21/25.
//

import Foundation

extension Double {
    func getTempInCelsius() -> Int {
        // 켈빈(K) - 273.15 = 섭씨
        return Int(floor(self - 273.15))
    }
}

/**
 - TimeZone 타입의 시간을 String 타입의 HH:mm 형태로 바꾸는 Extension입니다.
 
 - Parameter : timeZone(Int 타입)
 - Return : DataFormatter "HH:mm"이 적용된 String 타입
*/

extension NSObject {
    func makeTimeZoneToTime(timeZone: Int) -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: timeZone)
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: today)
    }
}
