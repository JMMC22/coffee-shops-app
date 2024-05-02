//
//  WeekDay.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 27/4/24.
//

import Foundation

enum WeekDay: Int {
    case sunday = 0
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    case unknown
}

extension WeekDay {
    var loacalized: String {
        switch self {
        case .monday:
            return String(localized: "monday")
        case .tuesday:
            return String(localized: "tuesday")
        case .wednesday:
            return String(localized: "wednesday")
        case .thursday:
            return String(localized: "thursday")
        case .friday:
            return String(localized: "friday")
        case .saturday:
            return String(localized: "saturday")
        case .sunday:
            return String(localized: "sunday")
        case .unknown:
            return ""
        }
    }
}
