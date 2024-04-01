//
//  GetFavouritesCoffeeShops.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol GetFavouritesCoffeeShops {
    func execute() -> Result<[Place], RequestError>
}

class DefaultGetFavouritesCoffeeShops {

    private let googlePlacesRepository: GooglePlacesRepository

    init(googlePlacesRepository: GooglePlacesRepository) {
        self.googlePlacesRepository = googlePlacesRepository
    }
}

extension DefaultGetFavouritesCoffeeShops: GetFavouritesCoffeeShops {
    func execute() -> Result<[Place], RequestError> {
        return googlePlacesRepository.fetchFavouritesCoffeeShops()
    }
}
