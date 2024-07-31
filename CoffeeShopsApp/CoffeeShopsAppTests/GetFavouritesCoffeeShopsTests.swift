//
//  GetFavouritesCoffeeShopsTests.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import XCTest
@testable import CoffeeShopsApp

class GooglePlacesRepositoryStub: GooglePlacesRepository {

    var getNearbyPlacesResult: Result<PlacesNearbySearch, RequestError>
    var getPlaceDetailsResult: Result<Place, RequestError>
    var fetchFavouritesCoffeeShopsResult: Result<[Place], RequestError>
    var isFavouriteCoffeeShopResult: Bool
    var updateFavouriteCoffeShopResult: Result<Bool, RequestError>

    init(getNearbyPlacesResult: Result<PlacesNearbySearch, RequestError> = .failure(.unknown),
         getPlaceDetailsResult: Result<Place, RequestError> = .failure(.unknown),
         fetchFavouritesCoffeeShopsResult: Result<[Place], RequestError> = .failure(.unknown),
         isFavouriteCoffeeShopResult: Bool = false,
         updateFavouriteCoffeShopResult: Result<Bool, RequestError> = .failure(.unknown)) {
        self.getNearbyPlacesResult = getNearbyPlacesResult
        self.getPlaceDetailsResult = getPlaceDetailsResult
        self.fetchFavouritesCoffeeShopsResult = fetchFavouritesCoffeeShopsResult
        self.isFavouriteCoffeeShopResult = isFavouriteCoffeeShopResult
        self.updateFavouriteCoffeShopResult = updateFavouriteCoffeShopResult
    }

    func getNearbyPlaces(location: String, radius: String, keyword: String) async -> Result<PlacesNearbySearch, RequestError> {
        getNearbyPlacesResult
    }

    func getPlaceDetails(id: String) async -> Result<Place, RequestError> {
        getPlaceDetailsResult
    }

    func fetchFavouritesCoffeeShops() -> Result<[Place], RequestError> {
        fetchFavouritesCoffeeShopsResult
    }

    func isFavouriteCoffeeShop(id: String) -> Bool {
        isFavouriteCoffeeShopResult
    }

    func updateFavouriteCoffeShop(_ place: Place) -> Result<Bool, RequestError> {
        updateFavouriteCoffeShopResult
    }
}

final class GetFavouritesCoffeeShopsTests: XCTestCase {

    func test_execute_success_return_sorted_array_when_repository_return_nonEmpty_array() throws {

        // GIVEN
        let mockArray = [
            Place(id: "1",name: "Coffee Shop A", location: PlaceLocation(latitude: 40.7128, longitude: -74.0060), // New York City
                isOpen: true, schedule: [], photos: [], address: "123 Coffee St, New York, NY",
                url: URL(string: "https://example.com/place1"), phoneNumber: "123-456-7890"
            ),
            Place(
                id: "2", name: "Coffee Shop B", location: PlaceLocation(latitude: 34.0522, longitude: -118.2437), // Los Angeles
                isOpen: false, schedule: [], photos: [], address: "456 Coffee Ave, Los Angeles, CA",
                url: URL(string: "https://example.com/place2"), phoneNumber: "098-765-4321"
            ),
            Place(id: "3", name: "Coffee Shop C", location: PlaceLocation(latitude: 51.5074, longitude: -0.1278), // London
                isOpen: true, schedule: [], photos: [], address: "789 Coffee Road, London, UK",
                url: URL(string: "https://example.com/place3"), phoneNumber: "112-233-4455"
            )
        ]

        let result:  Result<[Place], RequestError> = .success(mockArray)
        let stub = GooglePlacesRepositoryStub(fetchFavouritesCoffeeShopsResult: result)
        let sut = DefaultGetFavouritesCoffeeShops(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute()

        // THEN
        let capturedCoffeeShopsList = try XCTUnwrap(capturedResult.get())

        XCTAssertEqual(capturedCoffeeShopsList[0], mockArray[2])
        XCTAssertEqual(capturedCoffeeShopsList[1], mockArray[0])
        XCTAssertEqual(capturedCoffeeShopsList[2], mockArray[1])
    }

    func test_execute_success_return_sorted_array_when_repository_return_nonEmpty_sorted_array() throws {

        // GIVEN
        let mockArray = [
            Place(id: "3", name: "Coffee Shop C", location: PlaceLocation(latitude: 51.5074, longitude: -0.1278), // London
                isOpen: true, schedule: [], photos: [], address: "789 Coffee Road, London, UK",
                url: URL(string: "https://example.com/place3"), phoneNumber: "112-233-4455"
            ),
            Place(id: "1",name: "Coffee Shop A", location: PlaceLocation(latitude: 40.7128, longitude: -74.0060), // New York City
                isOpen: true, schedule: [], photos: [], address: "123 Coffee St, New York, NY",
                url: URL(string: "https://example.com/place1"), phoneNumber: "123-456-7890"
            ),
            Place(
                id: "2", name: "Coffee Shop B", location: PlaceLocation(latitude: 34.0522, longitude: -118.2437), // Los Angeles
                isOpen: false, schedule: [], photos: [], address: "456 Coffee Ave, Los Angeles, CA",
                url: URL(string: "https://example.com/place2"), phoneNumber: "098-765-4321"
            )
        ]

        let result:  Result<[Place], RequestError> = .success(mockArray)
        let stub = GooglePlacesRepositoryStub(fetchFavouritesCoffeeShopsResult: result)
        let sut = DefaultGetFavouritesCoffeeShops(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute()

        // THEN
        let capturedCoffeeShopsList = try XCTUnwrap(capturedResult.get())

        XCTAssertEqual(capturedCoffeeShopsList, mockArray)
    }

    func test_execute_success_return_empty_array_when_repository_return_empty_array() throws {

        // GIVEN
        let mockArray: [Place] = []

        let result:  Result<[Place], RequestError> = .success(mockArray)
        let stub = GooglePlacesRepositoryStub(fetchFavouritesCoffeeShopsResult: result)
        let sut = DefaultGetFavouritesCoffeeShops(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute()

        // THEN
        let capturedCoffeeShopsList = try XCTUnwrap(capturedResult.get())

        XCTAssertEqual(capturedCoffeeShopsList, mockArray)
    }
}
