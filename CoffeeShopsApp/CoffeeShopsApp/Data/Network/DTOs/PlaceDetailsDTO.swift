//
//  PlaceDetailsDTO.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import Foundation

struct PlaceDetailsDTO: Decodable {
    let htmlAttributions: [String]?
    let result: PlaceDTO?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case htmlAttributions = "html_attributions"
        case result
        case status
    }
}

extension PlaceDetailsDTO {
    func toDomain() -> Place? {
        result?.toDomain()
    }
}
