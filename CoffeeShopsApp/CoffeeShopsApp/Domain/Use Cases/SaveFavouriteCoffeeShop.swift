//
//  SaveFavouriteCoffeeShop.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol SaveFavouriteCoffeeShop {
    func execute(_ place: Place) -> Result<Place, RequestError>
}

class DefaultSaveFavouriteCoffeeShop {

    private let googlePlacesRepository: GooglePlacesRepository

    init(googlePlacesRepository: GooglePlacesRepository) {
        self.googlePlacesRepository = googlePlacesRepository
    }
}

extension DefaultSaveFavouriteCoffeeShop: SaveFavouriteCoffeeShop {
    func execute(_ place: Place) -> Result<Place, RequestError> {
        return googlePlacesRepository.saveFavouriteCoffeShop(place)
    }
}
