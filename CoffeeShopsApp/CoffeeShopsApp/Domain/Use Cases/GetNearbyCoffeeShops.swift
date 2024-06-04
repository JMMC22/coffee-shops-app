//
//  GetNearbyCoffeeShops.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

protocol GetNearbyCoffeeShops {
    func execute(latitude: Double, longitude: Double) async -> Result<[Place], RequestError>
}

class DefaultGetNearbyCoffeeShops {

    private let googlePlacesRepository: GooglePlacesRepository
    private let locationManager: LocationManager

    private let radius = "3500"
    private let keyword = "coffee"

    init(googlePlacesRepository: GooglePlacesRepository, locationManager: LocationManager = .shared) {
        self.googlePlacesRepository = googlePlacesRepository
        self.locationManager = locationManager
    }
}

extension DefaultGetNearbyCoffeeShops: GetNearbyCoffeeShops {
    func execute(latitude: Double, longitude: Double) async -> Result<[Place], RequestError> {
        let location: String = "\(latitude),\(longitude)"

        let result = await googlePlacesRepository.getNearbyPlaces(location: location, radius: radius, keyword: keyword)

        switch result {
        case .success(let response):
            let places = response.places
            let sortedByUserDistance = sortPlacesByDistance(places)
            return .success(sortedByUserDistance)
        case .failure(let error):
            return .failure(error)
        }
    }
}

// TODO: Duplicated
extension DefaultGetNearbyCoffeeShops {
    private func sortPlacesByDistance(_ places: [Place]) -> [Place] {
        return places.sorted(by: {
            locationManager.getDistance(to: $0.coordinate.latitude, longitude: $0.coordinate.longitude) <
            locationManager.getDistance(to: $1.coordinate.latitude, longitude: $1.coordinate.longitude)
        })
    }
}
