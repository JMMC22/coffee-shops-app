//
//  GooglePlacesUserDefaultsDatasource.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol GooglePlacesUserDefaultsDatasource {
    func fetchFavouritesCoffeeShops() -> Result<[PlaceUDS], RequestError>
    func saveFavouriteCoffeShop(_ place: PlaceUDS) -> Result<PlaceUDS, RequestError>
}

class DefaultGooglePlacesUserDefaultsDatasource {

    private let userDefaultsManager: UserDefaultManager

    init(userDefaultsManager: UserDefaultManager) {
        self.userDefaultsManager = userDefaultsManager
    }
}

extension DefaultGooglePlacesUserDefaultsDatasource: GooglePlacesUserDefaultsDatasource {
    
    func fetchFavouritesCoffeeShops() -> Result<[PlaceUDS], RequestError> {
        guard let encodedData = userDefaultsManager.object(for: .favouritesCoffeeShops) as? Data else {
            return .success([])
        }

        do {
            let favouritesList = try JSONDecoder().decode([PlaceUDS].self, from: encodedData)
            return .success(favouritesList)
        } catch {
            return .failure(.decode)
        }
    }

    func saveFavouriteCoffeShop(_ place: PlaceUDS) -> Result<PlaceUDS, RequestError> {
        guard var favouritesList = try? fetchFavouritesCoffeeShops().get() else {
            return .failure(.decode)
        }

        favouritesList.append(place)

        guard let encodedData = try? JSONEncoder().encode(favouritesList) else {
            return .failure(.decode)
        }

        userDefaultsManager.set(encodedData, for: .favouritesCoffeeShops)
        return .success(place)
    }
}
