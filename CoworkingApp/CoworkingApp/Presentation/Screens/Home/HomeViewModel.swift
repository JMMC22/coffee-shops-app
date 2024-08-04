//
//  HomeViewModel.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var nearbyCoworkingSpaces: [Place] = []
    @Published var nextPage: AppCoordinator.Page?

    private let getNearbyCoworkingSpaces: GetNearbyCoworkingSpaces
    private let locationManager: LocationManager

    private var cancellables = Set<AnyCancellable>()

    init(getNearbyCoworkingSpaces: GetNearbyCoworkingSpaces, locationManager: LocationManager = DefaultLocationManager.shared) {
        self.getNearbyCoworkingSpaces = getNearbyCoworkingSpaces
        self.locationManager = locationManager
    }

    func viewDidLoad() {
        subscribeToLocationStatus()
    }
}

extension HomeViewModel {

    private func getNearbyCoworkingSpaces(latitude: Double, longitude: Double) async {
        let result = await getNearbyCoworkingSpaces.execute(latitude: latitude, longitude: longitude)

        switch result {
        case .success(let places):
            getNearbyCoworkingSpacesDidSuccess(places)
        case .failure(let error):
            getNearbyCoworkingSpacesDidFail(error)
        }
    }

    private func getNearbyCoworkingSpacesDidSuccess(_ places: [Place]) {
        DispatchQueue.main.async {
            self.nearbyCoworkingSpaces = places
        }
    }

    private func getNearbyCoworkingSpacesDidFail(_ error: RequestError) {
        print("||DEBUG|| getNearbyCoffeShops - Fail: \(error.localizedDescription)")
    }
}

extension HomeViewModel {
    private func subscribeToLocationStatus() {
        locationManager.statusPublisher.sink { status in
            switch status {
            case .notDetermined:
                self.locationManager.requestLocationPermissions()
            case .authorizedAlways, .authorizedWhenInUse:
                print("||DEBUG|| Location permissions: APPROVED")
                self.subscribeToLocation()
                self.locationManager.requestLocation()
            default:
                print("||DEBUG|| Location permissions: DENIED")
            }
        }.store(in: &cancellables)
    }

    private func subscribeToLocation() {
        locationManager.lastLocationPublisher.sink { location in
            Task {
                await self.getNearbyCoworkingSpaces(latitude: location.latitude,
                                                    longitude: location.longitude)
            }
        }.store(in: &cancellables)
    }
}

extension HomeViewModel {

    func navigateToPlaceDetails(id: String) {
        nextPage = .coworkingSpaceDetails(id: id)
    }

    func navigateToFavourites() {
        nextPage = .favouritesCoworkingSpaces
    }
}
