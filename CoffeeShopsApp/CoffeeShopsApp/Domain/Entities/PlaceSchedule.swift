//
//  PlaceSchedule.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 27/4/24.
//

import Foundation

struct PlaceSchedule {
    let day: WeekDay
    let startHour: String
    let endHour: String
}

extension PlaceSchedule {
    func toString() -> String {
        String(day.loacalized + ": " + startHour + " - " + endHour)
    }
}
