//
//  IsFavouriteCoffeeShopTests.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import XCTest
@testable import CoffeeShopsApp

final class IsFavouriteCoffeeShopTests: XCTestCase {

    func test_execute_return_true_when_respository_return_true() {
        // GIVEN
        let result = true
        let stub = GooglePlacesRepositoryStub(isFavouriteCoffeeShopResult: result)
        let sut = DefaultIsFavouriteCoffeeShop(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute(id: "")

        // THEN
        XCTAssertEqual(capturedResult, result)
    }

    func test_execute_return_false_when_respository_return_false() {
        // GIVEN
        let result = false
        let stub = GooglePlacesRepositoryStub(isFavouriteCoffeeShopResult: result)
        let sut = DefaultIsFavouriteCoffeeShop(googlePlacesRepository: stub)

        // WHEN
        let capturedResult = sut.execute(id: "")

        // THEN
        XCTAssertEqual(capturedResult, result)
    }
}
