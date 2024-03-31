//
//  GetCoffeeShopDetails.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import Foundation

protocol GetCoffeeShopDetails {
    func getCoffeeShopDetails(id: String) async -> Result<Place, RequestError>
}

class DefaultGetCoffeeShopDetails {

    private let googlePlacesRepository: GooglePlacesRepository

    init(googlePlacesRepository: GooglePlacesRepository) {
        self.googlePlacesRepository = googlePlacesRepository
    }
}

extension DefaultGetCoffeeShopDetails: GetCoffeeShopDetails {

    func getCoffeeShopDetails(id: String) async -> Result<Place, RequestError> {
        let result = await googlePlacesRepository.getPlaceDetails(id: id)

        switch result {
        case .success(let response):
            return .success(response)
        case .failure(let error):
            return .failure(error)
        }
    }
}
