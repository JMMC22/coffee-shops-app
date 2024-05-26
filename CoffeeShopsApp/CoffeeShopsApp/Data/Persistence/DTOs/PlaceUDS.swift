//
//  PlaceUDS.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

struct PlaceUDS: Codable {
    let id: String
    let name: String
    let location: PlaceLocationUDS?
    let isOpen: Bool
    let address: String
    let url: URL?
    let phoneNumber: String
}

extension PlaceUDS {
    init(place: Place) {
        self.id = place.id
        self.name = place.name
        self.address = place.address
        self.location = PlaceLocationUDS(location: place.location)
        self.isOpen = place.isOpen
        self.url = place.url
        self.phoneNumber = place.phoneNumber
    }
}

extension PlaceUDS {
    func toDomain() -> Place {
        Place(id: id,
              name: name,
              location: location?.toDomain(),
              isOpen: isOpen,
              schedule: [], // TODO: Schedule DTO
              photos: [],
              address: address,
              url: url,
              phoneNumber: phoneNumber)
    }
}

struct PlaceLocationUDS: Codable {
    let latitude: Double
    let longitude: Double
}

extension PlaceLocationUDS {
    init(location: PlaceLocation?) {
        self.latitude = location?.latitude ?? 0
        self.longitude = location?.longitude ?? 0
    }
}

extension PlaceLocationUDS {
    func toDomain() -> PlaceLocation {
        PlaceLocation(latitude: latitude, longitude: longitude)
    }
}
