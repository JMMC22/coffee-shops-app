//
//  SaveFavouriteCoffeeShop.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol UpdateFavouriteCoworkingSpace {
    func execute(_ place: Place) -> Result<Bool, RequestError>
}

class DefaultUpdateFavouriteCoworkingSpace {

    private let googlePlacesRepository: GooglePlacesRepository

    init(googlePlacesRepository: GooglePlacesRepository) {
        self.googlePlacesRepository = googlePlacesRepository
    }
}

extension DefaultUpdateFavouriteCoworkingSpace: UpdateFavouriteCoworkingSpace {
    func execute(_ place: Place) -> Result<Bool, RequestError> {
        return googlePlacesRepository.updateFavouriteCoffeShop(place)
    }
}
