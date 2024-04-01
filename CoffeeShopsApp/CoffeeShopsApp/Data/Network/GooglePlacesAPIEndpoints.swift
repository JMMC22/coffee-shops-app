//
//  GooglePlacesAPIEndpoints.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

enum GooglePlacesAPIEndpoints {
    case getNearbyPlaces(location: String, radius: String, keyword: String)
    case getPlaceDetails(id: String)
    case getPlacePhoto(id: String, maxWidth: Int = 400)
}

extension GooglePlacesAPIEndpoints: Endpoint {

    var host: String {
        return EnvironmentConfiguration.googlePlacesHost ?? ""
    }

    var header: [String: String]? {
        switch self {
        case .getNearbyPlaces, .getPlaceDetails, .getPlacePhoto:
            return nil
        }
    }

    var path: String {
        switch self {
        case .getNearbyPlaces:
            return "/maps/api/place/nearbysearch/json"
        case .getPlaceDetails:
            return "/maps/api/place/details/json"
        case .getPlacePhoto:
            return "/maps/api/place/photo"
        }
    }

    var method: HTTPMethodType {
        switch self {
        case .getNearbyPlaces, .getPlaceDetails, .getPlacePhoto:
            return .get
        }
    }

    var body: [String: String]? {
        switch self {
        case .getNearbyPlaces, .getPlaceDetails, .getPlacePhoto:
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
        case .getPlaceDetails(let id):
            let queryItems = [URLQueryItem(name: "place_id", value: id),
                              URLQueryItem(name: "key", value: EnvironmentConfiguration.googlePlacesKey ?? "")
            ]
            return queryItems
        case .getPlacePhoto(let id, let maxWidth):
            let queryItems = [URLQueryItem(name: "maxwidth", value: String(maxWidth)),
                              URLQueryItem(name: "photo_reference", value: id),
                              URLQueryItem(name: "key", value: EnvironmentConfiguration.googlePlacesKey ?? "")
            ]
            return queryItems
        }
    }
}
