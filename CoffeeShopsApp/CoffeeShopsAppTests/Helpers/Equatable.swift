//
//  Equatable.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import Foundation
@testable import CoffeeShopsApp

extension RequestError: Equatable {

    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.error(let lhsStatusCode, let lhsData), .error(let rhsStatusCode, let rhsData)):
            return lhsStatusCode == rhsStatusCode && lhsData == rhsData
        case (.decode, .decode):
            return true
        case (.invalidURL, .invalidURL):
            return true
        case (.noResponse, .noResponse):
            return true
        case (.unauthorized, .unauthorized):
            return true
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}

extension PlacesNearbySearch: Equatable {
    public static func == (lhs: PlacesNearbySearch, rhs: PlacesNearbySearch) -> Bool {
        return lhs.places == rhs.places && lhs.totalPlaces == rhs.totalPlaces
    }
}
