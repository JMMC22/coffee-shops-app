//
//  PlaceDTO.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

struct PlaceDTO: Decodable {
    let id: String?
    let geometry: PlaceGeometryDTO?
    let name: String?
    let openingHours: PlaceOpeningHoursDTO?
    let photos: [PlacePhotoDTO]?
    let address: String?

    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case geometry
        case name
        case openingHours = "opening_hours"
        case photos
        case address = "vicinity"
    }
}

extension PlaceDTO {
    func toDomain() -> Place {
        Place(id: id ?? UUID().uuidString,
              name: name ?? "",
              location: geometry?.location?.toDomain(),
              isOpen: openingHours?.isOpenNow ?? false,
              photos: photos?.compactMap({ $0.toDomain()}) ?? [],
              address: address ?? "")
    }
}
