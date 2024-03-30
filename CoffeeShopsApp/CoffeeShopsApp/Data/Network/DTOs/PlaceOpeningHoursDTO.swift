//
//  PlaceOpeningHoursDTO.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

struct PlaceOpeningHoursDTO: Decodable {
    let isOpenNow: Bool?

    enum CodingKeys: String, CodingKey {
        case isOpenNow = "open_now"
    }
}
