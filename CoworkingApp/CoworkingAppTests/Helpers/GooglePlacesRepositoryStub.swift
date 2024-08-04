//
//  GooglePlacesRepositoryStub.swift
//  CoworkingAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import Foundation
@testable import CoworkingApp

class GooglePlacesRepositoryStub: GooglePlacesRepository {

    var getNearbyPlacesResult: Result<PlacesNearbySearch, RequestError>
    var getPlaceDetailsResult: Result<Place, RequestError>
    var fetchFavouritesPlacesResult: Result<[Place], RequestError>
    var isFavouritePlaceResult: Bool
    var updateFavouritePlaceResult: Result<Bool, RequestError>

    init(getNearbyPlacesResult: Result<PlacesNearbySearch, RequestError> = .failure(.unknown),
         getPlaceDetailsResult: Result<Place, RequestError> = .failure(.unknown),
         fetchFavouritesPlacesResult: Result<[Place], RequestError> = .failure(.unknown),
         isFavouritePlaceResult: Bool = false,
         updateFavouritePlaceResult: Result<Bool, RequestError> = .failure(.unknown)) {
        self.getNearbyPlacesResult = getNearbyPlacesResult
        self.getPlaceDetailsResult = getPlaceDetailsResult
        self.fetchFavouritesPlacesResult = fetchFavouritesPlacesResult
        self.isFavouritePlaceResult = isFavouritePlaceResult
        self.updateFavouritePlaceResult = updateFavouritePlaceResult
    }

    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearch, RequestError> {
        getNearbyPlacesResult
    }

    func getPlaceDetails(id: String) async -> Result<Place, RequestError> {
        getPlaceDetailsResult
    }

    func fetchFavouritesPlaces() -> Result<[Place], RequestError> {
        fetchFavouritesPlacesResult
    }

    func isFavouritePlace(id: String) -> Bool {
        isFavouritePlaceResult
    }

    func updateFavouritePlace(_ place: Place) -> Result<Bool, RequestError> {
        updateFavouritePlaceResult
    }
}
