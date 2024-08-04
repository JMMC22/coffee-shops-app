//
//  IsFavouriteCoworkingSpaceTests.swift
//  CoworkingAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import XCTest
@testable import CoworkingApp

final class IsFavouriteCoworkingSpaceTests: XCTestCase {

    func test_execute_return_true_when_respository_return_true() {
        // GIVEN
        let result = true
        let stub = GooglePlacesRepositoryStub(isFavouriteCoworkingSpaceResult: result)
        let sut = DefaultIsFavouriteCoworkingSpace(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute(id: "")

        // THEN
        XCTAssertEqual(capturedResult, result)
    }

    func test_execute_return_false_when_respository_return_false() {
        // GIVEN
        let result = false
        let stub = GooglePlacesRepositoryStub(isFavouriteCoworkingSpaceResult: result)
        let sut = DefaultIsFavouriteCoworkingSpace(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute(id: "")

        // THEN
        XCTAssertEqual(capturedResult, result)
    }
}
