//
//  PlaceLocationDTO.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

struct PlaceLocationDTO: Decodable {
    let latitude: Double?
    let longitude: Double?

    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}

extension PlaceLocationDTO {
    func toDomain() -> PlaceLocation {
        PlaceLocation(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }
}
