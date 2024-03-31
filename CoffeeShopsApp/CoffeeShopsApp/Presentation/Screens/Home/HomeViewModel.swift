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

    init(getNearbyCoffeeShops: GetNearbyCoffeeShops) {
        self.getNearbyCoffeeShops = getNearbyCoffeeShops
    }

    func viewDidLoad() {
        Task {
            await getNearbyCoffeShops(latitude: 40.4107974, longitude: -3.7122644)
        }
    }
}

extension HomeViewModel {

    private func getNearbyCoffeShops(latitude: Double, longitude: Double) async {
        let result = await getNearbyCoffeeShops.getNearbyPlaces(latitude: latitude, longitude: longitude)

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

//extension HomeViewModel {
//    private func subscribeToLocationStatus() {
//        locationManager.$status.sink { status in
//            switch status {
//            case .notDetermined:
//                self.locationManager.requestLocationPermissions()
//            case .authorizedAlways, .authorizedWhenInUse:
//                print("||DEBUG|| Location permissions: APPROVED")
//                self.locationManager.requestLocation()
//            default:
//                print("||DEBUG|| Location permissions: DENIED")
//            }
//        }.store(in: &cancellables)
//    }
//
//    private func subscribeToLocation() {
//        locationManager.$lastLocation.sink { location in
//            Task {
//                await self.getNearbyCoffeShops(latitude: location.latitude,
//                                               longitude: location.longitude)
//            }
//        }.store(in: &cancellables)
//    }
//}

extension HomeViewModel {

    func navigateToPlaceDetails(id: String) {
        nextPage = .coffeShopDetails(id: id)
    }

    func navigateToFavourites() {
        nextPage = .favouritesCoffeeShops
    }
}
