//
//  PlacesNearbySearchDTO.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

struct PlacesNearbySearchDTO: Decodable {
    let htmlAttributions: [String]?
    let results: [PlaceDTO]?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case htmlAttributions = "html_attributions"
        case results
        case status
    }
}

extension PlacesNearbySearchDTO {
    func toDomain() -> PlacesNearbySearch {
        PlacesNearbySearch(places: results?.compactMap({ $0.toDomain()}) ?? [],
                           totalPlaces: results?.count ?? 0)
    }
}
