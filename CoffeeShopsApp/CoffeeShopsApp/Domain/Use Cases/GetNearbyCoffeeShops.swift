//
//  GetNearbyCoffeeShops.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

protocol GetNearbyCoffeeShops {
    func getNearbyPlaces(latitude: Double, longitude: Double) async -> Result<[Place], RequestError>
}

class DefaultGetNearbyCoffeeShops {

    private let googlePlacesRepository: GooglePlacesRepository

    private let radius = "3500"
    private let keyword = "coffee"

    init(googlePlacesRepository: GooglePlacesRepository) {
        self.googlePlacesRepository = googlePlacesRepository
    }
}

extension DefaultGetNearbyCoffeeShops: GetNearbyCoffeeShops {
    func getNearbyPlaces(latitude: Double, longitude: Double) async -> Result<[Place], RequestError> {
        let location: String = "\(latitude),\(longitude)"

        let result = await googlePlacesRepository.getNearbyPlaces(location: location, radius: radius, keyword: keyword)

        switch result {
        case .success(let response):
            return .success(response.places)
        case .failure(let error):
            return .failure(error)
        }
    }
}
