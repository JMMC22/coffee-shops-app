//
//  IsFavouriteCoffeeShop.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 21/5/24.
//

import Foundation

protocol IsFavouriteCoffeeShop {
    func execute(id: String) -> Bool
}

class DefaultIsFavouriteCoffeeShop {

    private let googlePlacesRepository: GooglePlacesRepository

    init(googlePlacesRepository: GooglePlacesRepository) {
        self.googlePlacesRepository = googlePlacesRepository
    }
}

extension DefaultIsFavouriteCoffeeShop: IsFavouriteCoffeeShop {

    func execute(id: String) -> Bool {
        return googlePlacesRepository.isFavouriteCoffeeShop(id: id)
    }
}
