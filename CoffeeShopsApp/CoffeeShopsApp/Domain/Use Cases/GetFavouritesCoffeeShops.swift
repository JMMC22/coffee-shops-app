//
//  GetFavouritesCoffeeShops.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

protocol GetFavouritesCoffeeShops {
    func execute() -> Result<[Place], RequestError>
}

class DefaultGetFavouritesCoffeeShops {

    private let googlePlacesRepository: GooglePlacesRepository
    private let locationManager: LocationManager

    init(googlePlacesRepository: GooglePlacesRepository,
         locationManager: LocationManager = .shared) {
        self.googlePlacesRepository = googlePlacesRepository
        self.locationManager = locationManager
    }
}

extension DefaultGetFavouritesCoffeeShops: GetFavouritesCoffeeShops {
    func execute() -> Result<[Place], RequestError> {
        let result = googlePlacesRepository.fetchFavouritesCoffeeShops()

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
extension DefaultGetFavouritesCoffeeShops {
    private func sortPlacesByDistance(_ places: [Place]) -> [Place] {
        return places.sorted(by: {
            locationManager.getDistance(to: $0.coordinate.latitude, longitude: $0.coordinate.longitude) <
            locationManager.getDistance(to: $1.coordinate.latitude, longitude: $1.coordinate.longitude)
        })
    }
}
