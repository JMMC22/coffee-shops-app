//
//  GooglePlacesRepository.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

protocol GooglePlacesRepository {
    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearch, RequestError>
    func getPlaceDetails(id: String) async -> Result<Place, RequestError>
    func fetchFavouritesCoffeeShops() -> Result<[Place], RequestError>
    func isFavouriteCoffeeShop(id: String) -> Bool
    func updateFavouriteCoffeShop(_ place: Place) -> Result<Bool, RequestError>
}
