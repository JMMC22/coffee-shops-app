//
//  GetCoffeeShopDetailsTests.swift
//  CoworkingAppTests
//
//  Created by José María Márquez Crespo on 1/8/24.
//

import XCTest
@testable import CoworkingApp

final class GetCoffeeShopDetailsTests: XCTestCase {

    func test_execute_success_return_place_when_repository_return_place() async throws {
        // GIVEN
        let mockPlace = Place(id: "1",name: "Coffee Shop A", location: nil, isOpen: true, schedule: [],
                              photos: [], address: "123 Coffee St, New York, NY",
                              url: URL(string: "https://example.com/place1"), phoneNumber: "123-456-7890")
        let result: Result<Place, RequestError> = .success(mockPlace)
        let stub = GooglePlacesRepositoryStub(getPlaceDetailsResult: result)
        let sut = DefaultGetCoffeeShopDetails(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = await sut.execute(id: "")

        // THEN
        let captureUpdated = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(captureUpdated, mockPlace)
    }

    func test_execute_error_return_decode_error_when_repository_return_decode_error() async throws {
        // GIVEN
        let result: Result<Place, RequestError> = .failure(.decode)
        let stub = GooglePlacesRepositoryStub(getPlaceDetailsResult: result)
        let sut = DefaultGetCoffeeShopDetails(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = await sut.execute(id: "")

        // THEN
        XCTAssertEqual(capturedResult, result)
    }
}
