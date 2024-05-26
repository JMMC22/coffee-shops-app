//
//  HomeViewModel.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {

    @Published var nearbyCoffeeShops: [Place] = []
    @Published var nextPage: AppCoordinator.Page?

    private let getNearbyCoffeeShops: GetNearbyCoffeeShops
    private let locationManager: LocationManager

    private var cancellables = Set<AnyCancellable>()

    init(getNearbyCoffeeShops: GetNearbyCoffeeShops, locationManager: LocationManager = .shared) {
        self.getNearbyCoffeeShops = getNearbyCoffeeShops
        self.locationManager = locationManager
    }

    func viewDidLoad() {
        subscribeToLocationStatus()
    }
}

extension HomeViewModel {

    private func getNearbyCoffeShops(latitude: Double, longitude: Double) async {
        let result = await getNearbyCoffeeShops.execute(latitude: latitude, longitude: longitude)

        switch result {
        case .success(let places):
            getNearbyCoffeShopsDidSuccess(places)
        case .failure(let error):
            getNearbyCoffeShopsDidFail(error)
        }
    }

    private func getNearbyCoffeShopsDidSuccess(_ places: [Place]) {
        DispatchQueue.main.async {
            self.nearbyCoffeeShops = places
        }
    }

    private func getNearbyCoffeShopsDidFail(_ error: RequestError) {
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
                await self.getNearbyCoffeShops(latitude: location.latitude,
                                               longitude: location.longitude)
            }
        }.store(in: &cancellables)
    }
}

extension HomeViewModel {

    func navigateToPlaceDetails(id: String) {
        nextPage = .coffeShopDetails(id: id)
    }

    func navigateToFavourites() {
        nextPage = .favouritesCoffeeShops
    }
}
