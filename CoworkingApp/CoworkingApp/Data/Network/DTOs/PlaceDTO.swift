//
//  PlaceDTO.swift
//  CoworkingApp
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
    let url: String?
    let phoneNumber: String?
    let rating: Double?
    let totalRatings: Int?

    enum CodingKeys: String, CodingKey {
        case id = "place_id"
        case geometry
        case name
        case openingHours = "opening_hours"
        case photos
        case address = "vicinity"
        case url = "website"
        case phoneNumber = "international_phone_number"
        case rating
        case totalRatings = "user_ratings_total"
    }
}

extension PlaceDTO {
    func toDomain() -> Place {
        Place(id: id ?? UUID().uuidString,
              name: name ?? "",
              location: geometry?.location?.toDomain(),
              isOpen: openingHours?.isOpenNow ?? false,
              schedule: openingHours?.periods?.compactMap({ $0.toDomain() }) ?? [],
              photos: photos?.compactMap({ $0.toDomain()}) ?? [],
              address: address ?? "",
              url: URL(string: url ?? ""),
              phoneNumber: phoneNumber?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
              rating: rating ?? 0.0,
              totalRatings: totalRatings ?? 0)
    }
}
