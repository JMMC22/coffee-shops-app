//
//  UpdateFavouriteCoworkingSpaceTests.swift
//  CoworkingAppTests
//
//  Created by José María Márquez Crespo on 1/8/24.
//

import XCTest
@testable import CoworkingApp

final class UpdateFavouriteCoworkingSpaceTests: XCTestCase {

    func test_execute_success_return_true_when_repository_return_true() throws {
        // GIVEN
        let mockPlace = Place(id: "1",name: "Coffee Shop A", location: nil, isOpen: true, schedule: [],
                              photos: [], address: "123 Coffee St, New York, NY",
                              url: URL(string: "https://example.com/place1"), phoneNumber: "123-456-7890"
                          )
        let result: Result<Bool, RequestError> = .success(true)
        let stub = GooglePlacesRepositoryStub(updateFavouriteCoffeShopResult: result)
        let sut = DefaultUpdateFavouriteCoworkingSpace(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute(mockPlace)

        // THEN
        let captureUpdated = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(captureUpdated, try result.get())
    }

    func test_execute_success_return_false_when_repository_return_false() throws {
        // GIVEN
        let mockPlace = Place(id: "1",name: "Coffee Shop A", location: nil, isOpen: true, schedule: [],
                              photos: [], address: "123 Coffee St, New York, NY",
                              url: URL(string: "https://example.com/place1"), phoneNumber: "123-456-7890"
                          )
        let result: Result<Bool, RequestError> = .success(false)
        let stub = GooglePlacesRepositoryStub(updateFavouriteCoffeShopResult: result)
        let sut = DefaultUpdateFavouriteCoworkingSpace(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute(mockPlace)

        // THEN
        let captureUpdated = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(captureUpdated, try result.get())
    }

    func test_execute_success_return_decode_error_when_repository_return_decode_error() throws {
        // GIVEN
        let mockPlace = Place(id: "1",name: "Coffee Shop A", location: nil, isOpen: true, schedule: [],
                              photos: [], address: "123 Coffee St, New York, NY",
                              url: URL(string: "https://example.com/place1"), phoneNumber: "123-456-7890"
                          )
        let result: Result<Bool, RequestError> = .failure(.decode)
        let stub = GooglePlacesRepositoryStub(updateFavouriteCoffeShopResult: result)
        let sut = DefaultUpdateFavouriteCoworkingSpace(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute(mockPlace)

        // THEN
        XCTAssertEqual(capturedResult, result)
    }

    func test_execute_success_return_unknown_error_when_repository_return_unknown_error() throws {
        // GIVEN
        let mockPlace = Place(id: "1",name: "Coffee Shop A", location: nil, isOpen: true, schedule: [],
                              photos: [], address: "123 Coffee St, New York, NY",
                              url: URL(string: "https://example.com/place1"), phoneNumber: "123-456-7890"
                          )
        let result: Result<Bool, RequestError> = .failure(.unknown)
        let stub = GooglePlacesRepositoryStub(updateFavouriteCoffeShopResult: result)
        let sut = DefaultUpdateFavouriteCoworkingSpace(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute(mockPlace)

        // THEN
        XCTAssertEqual(capturedResult, result)
    }
}
