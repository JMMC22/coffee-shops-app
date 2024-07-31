//
//  GetFavouritesCoffeeShopsTests.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import XCTest
@testable import CoffeeShopsApp

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

    func test_execute_return_error_when_repository_return_error() throws {

        // GIVEN
        let result:  Result<[Place], RequestError> = .failure(.decode)
        let stub = GooglePlacesRepositoryStub(fetchFavouritesCoffeeShopsResult: result)
        let sut = DefaultGetFavouritesCoffeeShops(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute()

        // THEN
        XCTAssertEqual(capturedResult, result)
    }
}
