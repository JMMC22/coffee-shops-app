//
//  PlaceOpeningHoursDTO.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

struct PlaceOpeningHoursDTO: Decodable {
    let isOpenNow: Bool?
    let periods: [PlaceOpeningHoursPeriodDTO]?

    enum CodingKeys: String, CodingKey {
        case isOpenNow = "open_now"
        case periods
    }
}

struct PlaceOpeningHoursPeriodDTO: Decodable {
    let openHour: PlaceOpeningHoursPeriodItemDTO?
    let closeHour: PlaceOpeningHoursPeriodItemDTO?
    
    enum CodingKeys: String, CodingKey {
        case openHour = "open"
        case closeHour = "close"
    }
}

extension PlaceOpeningHoursPeriodDTO {
    func toDomain() -> PlaceSchedule {
        PlaceSchedule(day: WeekDay(rawValue: openHour?.day ?? 0) ?? .unknown,
                      startHour: (openHour?.time?.prefix(2) ?? "00") + ":" + (openHour?.time?.suffix(2) ?? "00"),
                      endHour: (closeHour?.time?.prefix(2) ?? "00") + ":" + (closeHour?.time?.suffix(2) ?? "00"))
    }
}

struct PlaceOpeningHoursPeriodItemDTO: Decodable {
    let day: Int?
    let time: String?
}
