//
//  GooglePlacesAPIEndpoints.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

enum GooglePlacesAPIEndpoints {
    case getNearbyPlaces(location: String, radius: String, keyword: String)
}

extension GooglePlacesAPIEndpoints: Endpoint {

    var host: String {
        return EnvironmentConfiguration.googlePlacesHost ?? ""
    }

    var header: [String: String]? {
        switch self {
        case .getNearbyPlaces:
            return nil
        }
    }

    var path: String {
        switch self {
        case .getNearbyPlaces:
            return "/maps/api/place/nearbysearch/json"
        }
    }

    var method: HTTPMethodType {
        switch self {
        case .getNearbyPlaces:
            return .get
        }
    }

    var body: [String: String]? {
        switch self {
        case .getNearbyPlaces:
            return nil
        }
    }

    var queryParameters: [URLQueryItem]? {
        switch self {
        case .getNearbyPlaces(let location, let radius, let keyword):
            let queryItems = [URLQueryItem(name: "location", value: location),
                              URLQueryItem(name: "radius", value: radius),
                              URLQueryItem(name: "keyword", value: keyword),
                              URLQueryItem(name: "key", value: EnvironmentConfiguration.googlePlacesKey ?? "")
            ]
            return queryItems
        }
    }
}
