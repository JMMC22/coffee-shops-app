//
//  GetNearbyCoffeeShops.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

protocol GetNearbyCoworkingSpaces {
    func execute(latitude: Double, longitude: Double) async -> Result<[Place], RequestError>
}

class DefaultGetNearbyCoworkingSpaces {

    private let googlePlacesRepository: GooglePlacesRepository
    private let locationManager: LocationManager

    private let radius = "3500"
    private let keyword = "coffee"

    init(googlePlacesRepository: GooglePlacesRepository, locationManager: LocationManager = DefaultLocationManager.shared) {
        self.googlePlacesRepository = googlePlacesRepository
        self.locationManager = locationManager
    }
}

extension DefaultGetNearbyCoworkingSpaces: GetNearbyCoworkingSpaces {
    func execute(latitude: Double, longitude: Double) async -> Result<[Place], RequestError> {
        let location: String = "\(latitude),\(longitude)"

        let result = await googlePlacesRepository.getNearbyPlaces(location: location, radius: radius, keyword: keyword)
        let favouritesResult = googlePlacesRepository.fetchFavouritesCoffeeShops()

        return await processResults(nearbyPlacesResult: result, favouritesResult: favouritesResult)
    }

    private func processResults(nearbyPlacesResult: Result<PlacesNearbySearch, RequestError>,
                                favouritesResult: Result<[Place], RequestError>) async -> Result<[Place], RequestError> {
        switch nearbyPlacesResult {
        case .success(let response):
            let places = response.places
            let favourites = extractFavourites(from: favouritesResult)
            
            let matchedPlaces = matchPlaces(places: places, favourites: favourites)
            let sortedPlaces = sortPlacesByDistance(matchedPlaces)
            
            return .success(sortedPlaces)
            
        case .failure(let error):
            return .failure(error)
        }
    }

    private func extractFavourites(from result: Result<[Place], RequestError>) -> [Place] {
        switch result {
        case .success(let favourites):
            return favourites
        case .failure:
            return []
        }
    }

    private func matchPlaces(places: [Place], favourites: [Place]) -> [Place] {
        return places.map { place in
            var newPlace = place
            newPlace.isFavourite = favourites.contains(where: { $0.id == place.id })
            return newPlace
        }
    }
}

// TODO: Duplicated
extension DefaultGetNearbyCoworkingSpaces {
    private func sortPlacesByDistance(_ places: [Place]) -> [Place] {
        return places.sorted(by: {
            locationManager.getDistance(to: $0.coordinate.latitude, longitude: $0.coordinate.longitude) <
            locationManager.getDistance(to: $1.coordinate.latitude, longitude: $1.coordinate.longitude)
        })
    }
}
