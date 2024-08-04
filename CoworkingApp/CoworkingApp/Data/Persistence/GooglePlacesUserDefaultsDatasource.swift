//
//  GooglePlacesUserDefaultsDatasource.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol GooglePlacesUserDefaultsDatasource {
    func fetchFavouritesPlaces() -> Result<[PlaceUDS], RequestError>
    func saveFavouritePlace(_ place: PlaceUDS) -> Result<Bool, RequestError>
    func removeFavouritePlace(id: String) -> Result<Bool, RequestError>
}

class DefaultGooglePlacesUserDefaultsDatasource {

    private let userDefaultsManager: UserDefaultManager

    init(userDefaultsManager: UserDefaultManager) {
        self.userDefaultsManager = userDefaultsManager
    }
}

extension DefaultGooglePlacesUserDefaultsDatasource: GooglePlacesUserDefaultsDatasource {
    
    func fetchFavouritesPlaces() -> Result<[PlaceUDS], RequestError> {
        guard let encodedData = userDefaultsManager.object(for: .favouritesCoworkingSpaces) as? Data else {
            return .success([])
        }

        do {
            let favouritesList = try JSONDecoder().decode([PlaceUDS].self, from: encodedData)
            return .success(favouritesList)
        } catch {
            return .failure(.decode)
        }
    }

    func saveFavouritePlace(_ place: PlaceUDS) -> Result<Bool, RequestError> {
        guard var favouritesList = try? fetchFavouritesPlaces().get() else {
            return .failure(.decode)
        }

        favouritesList.append(place)

        guard let encodedData = try? JSONEncoder().encode(favouritesList) else {
            return .failure(.decode)
        }

        userDefaultsManager.set(encodedData, for: .favouritesCoworkingSpaces)
        return .success(true)
    }

    func removeFavouritePlace(id: String) -> Result<Bool, RequestError> {
        guard var favouritesList = try? fetchFavouritesPlaces().get() else {
            return .failure(.decode)
        }

        guard let index = favouritesList.firstIndex(where: { $0.id == id }) else {
            return .failure(.unknown)
        }

        favouritesList.remove(at: index)

        guard let encodedData = try? JSONEncoder().encode(favouritesList) else {
            return .failure(.decode)
        }

        userDefaultsManager.set(encodedData, for: .favouritesCoworkingSpaces)
        return .success(false)
    }
}
