//
//  GetFavouritesCoffeeShopsTests.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import XCTest
@testable import CoffeeShopsApp

class GooglePlacesRepositoryStub: GooglePlacesRepository {

    var shouldReturnError: Bool = false
    var errorToReturn: RequestError = .unknown

    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearch, RequestError> {
        if shouldReturnError {
            return .failure(errorToReturn)
        } else {
            let places = [
                Place(id: "1", name: "Coffee Shop A", location: nil, isOpen: true,schedule: [], photos: [],
                      address: "123 Coffee St",url: URL(string: "https://example.com"),phoneNumber: "123-456-7890"
                ),
                Place(id: "2", name: "Coffee Shop B", location: nil, isOpen: false, schedule: [], photos: [],
                      address: "456 Coffee Ave", url: URL(string: "https://example.com"), phoneNumber: "098-765-4321"
                )
            ]

            let searchResult = PlacesNearbySearch(places: places, totalPlaces: places.count)
            return .success(searchResult)
        }
    }

    func getPlaceDetails(id: String) async -> Result<Place, RequestError> {
        if shouldReturnError {
            return .failure(errorToReturn)
        } else {
            let place = Place(id: id, name: "Detailed Place", location: nil, isOpen: true, schedule: [],
                photos: [], address: "789 Detailed Rd", url: URL(string: "https://example.com"), phoneNumber: "321-654-9870"
            )

            return .success(place)
        }
    }

    func fetchFavouritesCoffeeShops() -> Result<[Place], RequestError> {
        if shouldReturnError {
            return .failure(errorToReturn)
        } else {
            let favouriteCoffees = [
                Place(id: "1", name: "Favourite Coffee Shop", location: nil, isOpen: true, schedule: [],
                    photos: [], address: "101 Favourite Blvd", url: URL(string: "https://example.com"), phoneNumber: "555-123-4567"
                )
            ]
            return .success(favouriteCoffees)
        }
    }

    func isFavouriteCoffeeShop(id: String) -> Bool {
        if shouldReturnError {
            return false
        } else {
            return id == "1"
        }
    }

    func updateFavouriteCoffeShop(_ place: Place) -> Result<Bool, RequestError> {
        if shouldReturnError {
            return .failure(errorToReturn)
        } else {
            return .success(true)
        }
    }
}

final class GetFavouritesCoffeeShopsTests: XCTestCase {
    
    func test_execute_success_return_sorted_array_when_repository_return_nonEmpty_array() {
        
        // GIVEN
        let stub = GooglePlacesRepositoryStub()
        let sut = DefaultGetFavouritesCoffeeShops(googlePlacesRepository: stub)
    }
}
