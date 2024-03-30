//
//  GooglePlacesRemoteDatasource.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

protocol GooglePlacesRemoteDatasource {
    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearchDTO, RequestError>
}

class DefaultGooglePlacesRemoteDatasource {

    private let httpClient: HTTPClient

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension DefaultGooglePlacesRemoteDatasource: GooglePlacesRemoteDatasource {

    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearchDTO, RequestError> {
        let endpoint = GooglePlacesAPIEndpoints.getNearbyPlaces(location: location, radius: radius, keyword: keyword)
        let result = await httpClient.request(endpoint: endpoint)

        switch result {
        case .success(let response):
            guard let nearbyPlacesResponse = try? JSONDecoder().decode(PlacesNearbySearchDTO.self,
                                                                       from: response) else {
                return .failure(.decode)
            }
            return .success(nearbyPlacesResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
}
