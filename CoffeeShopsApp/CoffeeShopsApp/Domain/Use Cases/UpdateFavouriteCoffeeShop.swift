//
//  SaveFavouriteCoffeeShop.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol UpdateFavouriteCoffeeShop {
    func execute(_ place: Place) -> Result<Bool, RequestError>
}

class DefaultUpdateFavouriteCoffeeShop {

    private let googlePlacesRepository: GooglePlacesRepository

    init(googlePlacesRepository: GooglePlacesRepository) {
        self.googlePlacesRepository = googlePlacesRepository
    }
}

extension DefaultUpdateFavouriteCoffeeShop: UpdateFavouriteCoffeeShop {
    func execute(_ place: Place) -> Result<Bool, RequestError> {
        return googlePlacesRepository.updateFavouriteCoffeShop(place)
    }
}
