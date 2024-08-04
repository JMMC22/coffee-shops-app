//
//  GetFavouritesCoffeeShops.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol GetFavouritesCoworkingSpaces {
    func execute() -> Result<[Place], RequestError>
}

class DefaultGetFavouritesCoworkingSpaces {

    private let googlePlacesRepository: GooglePlacesRepository
    private let locationManager: LocationManager

    init(googlePlacesRepository: GooglePlacesRepository,
         locationManager: LocationManager = DefaultLocationManager.shared) {
        self.googlePlacesRepository = googlePlacesRepository
        self.locationManager = locationManager
    }
}

extension DefaultGetFavouritesCoworkingSpaces: GetFavouritesCoworkingSpaces {
    func execute() -> Result<[Place], RequestError> {
        let result = googlePlacesRepository.fetchFavouritesPlaces()

        switch result {
        case .success(let response):
            let places = response
            let sortedByUserDistance = sortPlacesByDistance(places)
            return .success(sortedByUserDistance)
        case .failure(let error):
            return .failure(error)
        }
    }
}

// TODO: Duplicated
extension DefaultGetFavouritesCoworkingSpaces {
    private func sortPlacesByDistance(_ places: [Place]) -> [Place] {
        return places.sorted(by: {
            locationManager.getDistance(to: $0.coordinate.latitude, longitude: $0.coordinate.longitude) <
            locationManager.getDistance(to: $1.coordinate.latitude, longitude: $1.coordinate.longitude)
        })
    }
}
