//
//  DefaultGooglePlacesRepository.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

class DefaultGooglePlacesRepository {

    private let googlePlacesRemoteDatasource: GooglePlacesRemoteDatasource
    private let googlePlacesUserDefaultsDatasource: GooglePlacesUserDefaultsDatasource

    init(googlePlacesRemoteDatasource: GooglePlacesRemoteDatasource,
         googlePlacesUserDefaultsDatasource: GooglePlacesUserDefaultsDatasource) {
        self.googlePlacesRemoteDatasource = googlePlacesRemoteDatasource
        self.googlePlacesUserDefaultsDatasource = googlePlacesUserDefaultsDatasource
    }
}

// MARK: Remote
extension DefaultGooglePlacesRepository: GooglePlacesRepository {

    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearch, RequestError> {
        let result = await googlePlacesRemoteDatasource.getNearbyPlaces(location: location, radius: radius, keyword: keyword)

        switch result {
        case .success(let response):
            return .success(response.toDomain())
        case .failure(let error):
            return .failure(error)
        }
    }

    func getPlaceDetails(id: String) async -> Result<Place, RequestError> {
        let result = await googlePlacesRemoteDatasource.getPlaceDetails(id: id)
        switch result {
        case .success(let response):
            guard let place = response.toDomain() else { return .failure(.decode) }
            return .success(place)
        case .failure(let error):
            return .failure(error)
        }
    }
}

// MARK: Local Persistence
extension DefaultGooglePlacesRepository {

    func saveFavouriteCoffeShop(_ place: Place) -> Result<Place, RequestError> {
        let dto = PlaceUDS(place: place)
        let result = googlePlacesUserDefaultsDatasource.saveFavouriteCoffeShop(dto)

        switch result {
        case .success(let response):
            return .success(response.toDomain())
        case .failure(let error):
            return .failure(error)
        }
    }

    func fetchFavouritesCoffeeShops() -> Result<[Place], RequestError> {
        let result = googlePlacesUserDefaultsDatasource.fetchFavouritesCoffeeShops()

        switch result {
        case .success(let response):
            return .success(response.map({ $0.toDomain() }))
        case .failure(let error):
            return .failure(error)
        }
    }

    func isFavouriteCoffeeShop(id: String) -> Bool {
        guard let favouriteList = try? fetchFavouritesCoffeeShops().get() else {
            return false
        }

        return favouriteList.contains(where: { $0.id == id })
    }
}
