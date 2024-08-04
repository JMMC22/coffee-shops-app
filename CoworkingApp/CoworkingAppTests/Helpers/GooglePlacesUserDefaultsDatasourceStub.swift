//
//  GooglePlacesUserDefaultsDatasourceStub.swift
//  CoworkingAppTests
//
//  Created by José María Márquez Crespo on 1/8/24.
//

import Foundation
@testable import CoworkingApp

class GooglePlacesUserDefaultsDatasourceStub: GooglePlacesUserDefaultsDatasource {

    let fetchFavouritesPlacesResult: Result<[PlaceUDS], RequestError>
    let saveFavouritePlaceResult: Result<Bool, RequestError>
    let removeFavouritePlaceResult: Result<Bool, RequestError>

    init(fetchFavouritesPlacesResult: Result<[PlaceUDS], RequestError> = .failure(.unknown),
         saveFavouritePlaceResult: Result<Bool, RequestError> = .failure(.unknown),
         removeFavouritePlaceResult: Result<Bool, RequestError> = .failure(.unknown)) {
        self.fetchFavouritesPlacesResult = fetchFavouritesPlacesResult
        self.saveFavouritePlaceResult = saveFavouritePlaceResult
        self.removeFavouritePlaceResult = removeFavouritePlaceResult
    }

    func fetchFavouritesPlaces() -> Result<[PlaceUDS], RequestError> {
        return fetchFavouritesPlacesResult
    }

    func saveFavouritePlace(_ place: PlaceUDS) -> Result<Bool, RequestError> {
        return saveFavouritePlaceResult
    }

    func removeFavouritePlace(id: String) -> Result<Bool, RequestError> {
        return removeFavouritePlaceResult
    }
}
