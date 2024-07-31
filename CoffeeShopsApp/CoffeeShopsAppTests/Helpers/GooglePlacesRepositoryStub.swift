//
//  GooglePlacesRepositoryStub.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import Foundation
@testable import CoffeeShopsApp

class GooglePlacesRepositoryStub: GooglePlacesRepository {

    var getNearbyPlacesResult: Result<PlacesNearbySearch, RequestError>
    var getPlaceDetailsResult: Result<Place, RequestError>
    var fetchFavouritesCoffeeShopsResult: Result<[Place], RequestError>
    var isFavouriteCoffeeShopResult: Bool
    var updateFavouriteCoffeShopResult: Result<Bool, RequestError>

    init(getNearbyPlacesResult: Result<PlacesNearbySearch, RequestError> = .failure(.unknown),
         getPlaceDetailsResult: Result<Place, RequestError> = .failure(.unknown),
         fetchFavouritesCoffeeShopsResult: Result<[Place], RequestError> = .failure(.unknown),
         isFavouriteCoffeeShopResult: Bool = false,
         updateFavouriteCoffeShopResult: Result<Bool, RequestError> = .failure(.unknown)) {
        self.getNearbyPlacesResult = getNearbyPlacesResult
        self.getPlaceDetailsResult = getPlaceDetailsResult
        self.fetchFavouritesCoffeeShopsResult = fetchFavouritesCoffeeShopsResult
        self.isFavouriteCoffeeShopResult = isFavouriteCoffeeShopResult
        self.updateFavouriteCoffeShopResult = updateFavouriteCoffeShopResult
    }

    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearch, RequestError> {
        getNearbyPlacesResult
    }

    func getPlaceDetails(id: String) async -> Result<Place, RequestError> {
        getPlaceDetailsResult
    }

    func fetchFavouritesCoffeeShops() -> Result<[Place], RequestError> {
        fetchFavouritesCoffeeShopsResult
    }

    func isFavouriteCoffeeShop(id: String) -> Bool {
        isFavouriteCoffeeShopResult
    }

    func updateFavouriteCoffeShop(_ place: Place) -> Result<Bool, RequestError> {
        updateFavouriteCoffeShopResult
    }
}
