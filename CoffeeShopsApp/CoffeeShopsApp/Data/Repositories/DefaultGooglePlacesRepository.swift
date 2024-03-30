//
//  DefaultGooglePlacesRepository.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

class DefaultGooglePlacesRepository {

    private let googlePlacesRemoteDatasource: GooglePlacesRemoteDatasource

    init(googlePlacesRemoteDatasource: GooglePlacesRemoteDatasource) {
        self.googlePlacesRemoteDatasource = googlePlacesRemoteDatasource
    }
}

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
}