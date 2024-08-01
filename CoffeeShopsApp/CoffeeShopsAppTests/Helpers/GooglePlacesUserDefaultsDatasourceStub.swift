//
//  GooglePlacesUserDefaultsDatasourceStub.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 1/8/24.
//

import Foundation
@testable import CoffeeShopsApp

class GooglePlacesUserDefaultsDatasourceStub: GooglePlacesUserDefaultsDatasource {

    let fetchFavouritesResult: Result<[PlaceUDS], RequestError>
    let saveFavouriteResult: Result<Bool, RequestError>
    let removeFavouriteResult: Result<Bool, RequestError>

    init(fetchFavouritesResult: Result<[PlaceUDS], RequestError> = .failure(.unknown),
         saveFavouriteResult: Result<Bool, RequestError> = .failure(.unknown),
         removeFavouriteResult: Result<Bool, RequestError> = .failure(.unknown)) {
        self.fetchFavouritesResult = fetchFavouritesResult
        self.saveFavouriteResult = saveFavouriteResult
        self.removeFavouriteResult = removeFavouriteResult
    }

    func fetchFavouritesCoffeeShops() -> Result<[PlaceUDS], RequestError> {
        return fetchFavouritesResult
    }

    func saveFavouriteCoffeShop(_ place: PlaceUDS) -> Result<Bool, RequestError> {
        return saveFavouriteResult
    }

    func removeFavouriteCoffeShop(id: String) -> Result<Bool, RequestError> {
        return removeFavouriteResult
    }
}
