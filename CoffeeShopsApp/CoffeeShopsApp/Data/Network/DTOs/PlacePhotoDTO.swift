//
//  PlacePhotoDTO.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

struct PlacePhotoDTO: Decodable {
    let id: String?

    enum CodingKeys: String, CodingKey {
        case id = "photo_reference"
    }
}

extension PlacePhotoDTO {
    func toDomain() -> PlacePhoto {
        PlacePhoto(id: id ?? "")
    }
}
