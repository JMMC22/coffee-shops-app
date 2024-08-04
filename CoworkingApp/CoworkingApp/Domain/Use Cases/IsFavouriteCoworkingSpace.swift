//
//  IsFavouriteCoffeeShop.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 21/5/24.
//

import Foundation

protocol IsFavouriteCoworkingSpace {
    func execute(id: String) -> Bool
}

class DefaultIsFavouriteCoworkingSpace {

    private let googlePlacesRepository: GooglePlacesRepository

    init(googlePlacesRepository: GooglePlacesRepository) {
        self.googlePlacesRepository = googlePlacesRepository
    }
}

extension DefaultIsFavouriteCoworkingSpace: IsFavouriteCoworkingSpace {

    func execute(id: String) -> Bool {
        return googlePlacesRepository.isFavouriteCoffeeShop(id: id)
    }
}
