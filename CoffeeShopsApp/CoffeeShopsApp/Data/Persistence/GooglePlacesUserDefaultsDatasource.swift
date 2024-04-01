//
//  GooglePlacesUserDefaultsDatasource.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol GooglePlacesUserDefaultsDatasource {
    func saveFavouriteCoffeShop(_ place: Place) -> Result<Place, RequestError>
    func fetchFavouritesCoffeeShops() -> Result<[Place], RequestError>
}

class DefaultGooglePlacesUserDefaultsDatasource {

    private let userDefaultsManager: UserDefaultManager

    init(userDefaultsManager: UserDefaultManager) {
        self.userDefaultsManager = userDefaultsManager
    }
}

extension DefaultGooglePlacesUserDefaultsDatasource: GooglePlacesUserDefaultsDatasource {

    func saveFavouriteCoffeShop(_ place: Place) -> Result<Place, RequestError> {
        let result = self.fetchFavouritesCoffeeShops()

        switch result {
        case .success(let list):
            var favouritesList = list
            favouritesList.append(place)
            self.userDefaultsManager.set(favouritesList, for: .favouritesCoffeeShops)
            return .success(place)
        case .failure(let error):
            return .failure(error)
        }
    }

    func fetchFavouritesCoffeeShops() -> Result<[Place], RequestError> {
        if let result = userDefaultsManager.get(for: .favouritesCoffeeShops) as [Place]? {
            return .success(result)
        } else {
            return .failure(.noResponse)
        }
    }
}
