//
//  CoffeeShopItemListViewModel.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 4/6/24.
//

import Foundation

class CoffeeShopItemListViewModel: ObservableObject {
    
    @Published var place: Place
    @Published var distance: String = ""

    private let locationManager: LocationManager

    init(place: Place, locationManager: LocationManager = .shared) {
        self.place = place
        self.locationManager = locationManager
    }
}

extension CoffeeShopItemListViewModel {
    func getDistance() {
        let distanceToPlace = locationManager.getDistance(to: place.coordinate.latitude, longitude: place.coordinate.longitude)
        distance = getFormattedDistance(distanceToPlace)
    }

    private func getFormattedDistance(_ distance: Double) -> String {
        return distance < 1000 ? getMeters(distance) : getKilometers(distance)
    }

    private func getMeters(_ distance: Double) -> String {
        return "\(Int(distance)) m"
    }

    private func getKilometers(_ distance: Double) -> String {
        return String(format: "%.1f km", (distance / 1000))
    }
}
