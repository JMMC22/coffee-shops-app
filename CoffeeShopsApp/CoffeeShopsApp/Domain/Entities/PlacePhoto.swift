//
//  PlacePhoto.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

struct PlacePhoto {
    let id: String
}

extension PlacePhoto {
    func getPlacePhotoURL() -> URL? {
        let endpoint = GooglePlacesAPIEndpoints.getPlacePhoto(id: self.id)

        var urlComponents = URLComponents()

        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        if let queryParameters = endpoint.queryParameters {
            urlComponents.queryItems = queryParameters
        }

        guard let url = urlComponents.url else {
            return nil
        }

        return url
    }
}
