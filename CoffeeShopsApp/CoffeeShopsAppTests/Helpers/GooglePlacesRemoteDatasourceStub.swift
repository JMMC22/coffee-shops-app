//
//  GooglePlacesRemoteDatasourceStub.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 1/8/24.
//

import Foundation
@testable import CoffeeShopsApp

class GooglePlacesRemoteDatasourceStub: GooglePlacesRemoteDatasource {

    let getNearbyPlacesResult: Result<PlacesNearbySearchDTO, RequestError>
    let getPlaceDetailsResult: Result<PlaceDetailsDTO, RequestError>

    init(getNearbyPlacesResult: Result<PlacesNearbySearchDTO, RequestError> = .failure(.unknown),
         getPlaceDetailsResult: Result<PlaceDetailsDTO, RequestError> = .failure(.unknown)) {
        self.getNearbyPlacesResult = getNearbyPlacesResult
        self.getPlaceDetailsResult = getPlaceDetailsResult
    }

    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearchDTO, RequestError> {
        return getNearbyPlacesResult
    }

    func getPlaceDetails(id: String) async -> Result<PlaceDetailsDTO, RequestError> {
        getPlaceDetailsResult
    }
}
