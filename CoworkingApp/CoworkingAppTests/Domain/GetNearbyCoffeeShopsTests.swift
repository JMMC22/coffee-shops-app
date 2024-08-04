//
//  GetNearbyCoffeeShopsTests.swift
//  CoworkingAppTests
//
//  Created by José María Márquez Crespo on 1/8/24.
//

import XCTest
@testable import CoworkingApp

final class GetNearbyCoffeeShopsTests: XCTestCase {

    func test_execute_success_return_nonEmpty_sorted_array_when_repository_return_nonEmpty_array() async throws {
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
        let mockResponse = PlacesNearbySearch(places: mockArray, totalPlaces: mockArray.count)

        let result: Result<PlacesNearbySearch, RequestError> = .success(mockResponse)
        let stub = GooglePlacesRepositoryStub(getNearbyPlacesResult: result)
        let locationStub = LocationManagerStub()
        let sut = DefaultGetNearbyCoffeeShops(googlePlacesRepository: stub, locationManager: locationStub)

        // WHEN
        let capturedResult = await sut.execute(latitude: 0, longitude: 0)

        // THEN
        let captureUpdated = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(captureUpdated[0], mockArray[2])
        XCTAssertEqual(captureUpdated[1], mockArray[0])
        XCTAssertEqual(captureUpdated[2], mockArray[1])
    }

    func test_execute_success_return_empty_array_when_repository_return_empty_array() async throws {
        // GIVEN
        let mockArray: [Place] = []
        let mockResponse = PlacesNearbySearch(places: mockArray, totalPlaces: mockArray.count)

        let result: Result<PlacesNearbySearch, RequestError> = .success(mockResponse)
        let stub = GooglePlacesRepositoryStub(getNearbyPlacesResult: result)
        let sut = DefaultGetNearbyCoffeeShops(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = await sut.execute(latitude: 0, longitude: 0)

        // THEN
        let captureUpdated = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(captureUpdated, mockArray)
    }

    func test_execute_success_return_nonEmpty_sorted_with_favourites_array_when_repository_return_nonEmpty_array() async throws {
        // GIVEN
        var mockArray = [
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
        
        let favourite = Place(id: "3", name: "Coffee Shop C", location: PlaceLocation(latitude: 51.5074, longitude: -0.1278), // London
                              isOpen: true, schedule: [], photos: [], address: "789 Coffee Road, London, UK",
                              url: URL(string: "https://example.com/place3"), phoneNumber: "112-233-4455")
        mockArray.append(favourite)

        let mockNearbyResponse = PlacesNearbySearch(places: mockArray, totalPlaces: mockArray.count)
        let mockFavouritesArray = [favourite]

        let nearbyResult: Result<PlacesNearbySearch, RequestError> = .success(mockNearbyResponse)
        let favouritesResult: Result<[Place], RequestError> = .success(mockFavouritesArray)

        let stub = GooglePlacesRepositoryStub(getNearbyPlacesResult: nearbyResult, fetchFavouritesCoffeeShopsResult: favouritesResult)
        let sut = DefaultGetNearbyCoffeeShops(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = await sut.execute(latitude: 0, longitude: 0)

        // THEN
        let captureUpdated = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(captureUpdated[1], mockArray[0])
        XCTAssertEqual(captureUpdated[2], mockArray[1])
        XCTAssertEqual(captureUpdated[0], mockArray[2])
        XCTAssertTrue(captureUpdated[0].isFavourite)
    }
}
