//
//  MapApp.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 7/6/24.
//

import Foundation
import UIKit

public enum MapApp: CaseIterable {
    case appleMaps
    case googleMaps
    case waze

    public var appName: String {
        switch self {
        case .appleMaps:
            return "Apple Maps"
        case .googleMaps:
            return "Google Maps"
        case .waze:
            return "Waze"
        }
    }

    public var baseUrl: String {
        switch self {
        case .appleMaps:
            return "http://maps.apple.com"
        case .googleMaps:
            return "comgooglemaps://"
        case .waze:
            return "waze://"
        }
    }

    public static var availableApps: [MapApp] {
        return self.allCases.filter { $0.available }
    }
}

extension MapApp {
    public var url: URL? {
        return URL(string: self.baseUrl)
    }

    public var available: Bool {
        guard let url = self.url else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
}

extension MapApp {
    func appUrl(latitude: Double?, longitude: Double?) -> String {
        guard let latitude, let longitude else { return "" }

        var urlString = self.baseUrl

        switch self {
        case .appleMaps:
            urlString.append("?q=\(latitude),\(longitude)=d&t=h")
        case .googleMaps:
            urlString.append("?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")
        case .waze:
            urlString.append("?ll=\(latitude),\(longitude)&navigate=yes")
        }

        return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
    }
}
