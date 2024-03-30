//
//  EnvironmentConfiguration.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

enum EnvironmentConfiguration {

    private enum Keys: String {
        case googlePlacesHost = "GOOGLE_PLACES_HOST"
        case googlePlacesKey = "GOOGLE_PLACES_KEY"
    }

    static var infoDictionary: [String: Any]? {
        guard let dict = Bundle.main.infoDictionary else {
            return nil
        }

        return dict
    }

    static var googlePlacesHost: String? {
        guard let infoDict = infoDictionary,
              let host = infoDict[Keys.googlePlacesHost.rawValue] as? String else {
            return nil
        }

        return host
    }

    static var googlePlacesKey: String? {
        guard let infoDict = infoDictionary,
              let key = infoDict[Keys.googlePlacesKey.rawValue] as? String else {
            return nil
        }

        return key
    }
}
