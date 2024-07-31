//
//  Equatable.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import Foundation
@testable import CoffeeShopsApp

extension RequestError: Equatable {

    static public func == (lhs: RequestError, rhs: RequestError) -> Bool {
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
