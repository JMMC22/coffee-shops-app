//
//  CoffeeShopDetailsViewModel.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import Foundation
import CoreLocation
import MapKit

class CoffeeShopDetailsViewModel: ObservableObject {

    @Published var name: String = ""
    @Published var address: String = ""
    @Published var isOpenNow: Bool = false
    @Published var coordinate: MKCoordinateRegion = .init()
    @Published var isFavourite: Bool = false
    @Published var imagesURLs: [URL?] = []
    @Published var schedule: String = ""
    @Published var distance: String = ""

    @Published var isLoading: Bool = true
    @Published var error: RequestError?

    // MARK: External
    var coffeeURL: URL?
    var phoneNumber: String = ""

    private let getCoffeeShopDetails: GetCoffeeShopDetails
    private let updateFavouriteCoffeeShop: UpdateFavouriteCoffeeShop
    private let isFavouriteCoffeeShop: IsFavouriteCoffeeShop
    private let locationManager: LocationManager

    private let id: String
    private var coffeeShop: Place?

    init(_ id: String, 
         getCoffeeShopDetails: GetCoffeeShopDetails,
         updateFavouriteCoffeeShop: UpdateFavouriteCoffeeShop,
         isFavouriteCoffeeShop: IsFavouriteCoffeeShop,
         locationManager: LocationManager = .shared) {
        self.id = id
        self.getCoffeeShopDetails = getCoffeeShopDetails
        self.updateFavouriteCoffeeShop = updateFavouriteCoffeeShop
        self.isFavouriteCoffeeShop = isFavouriteCoffeeShop
        self.locationManager = locationManager
    }
}

extension CoffeeShopDetailsViewModel {

    func getCoffeeShopsDetails() async {
        let result = await getCoffeeShopDetails.execute(id: id)

        switch result {
        case .success(let coffeeShop):
            getCoffeeShopsDetailsDidSuccess(coffeeShop)
        case .failure(let error):
            getCoffeeShopsDetailsDidFail(error)
        }
    }

    private func getCoffeeShopsDetailsDidSuccess(_ coffeeShop: Place) {
        self.coffeeShop = coffeeShop
        let isFavourite = isFavouriteCoffeeShop.execute(id: coffeeShop.id)

        DispatchQueue.main.async {
            self.name = coffeeShop.name
            self.address = coffeeShop.address
            self.isOpenNow = coffeeShop.isOpen
            self.coordinate = self.createCoordinateRegion(coffeeShop.coordinate)
            self.imagesURLs = coffeeShop.photos.map({ $0.getPlacePhotoURL() })
            self.coffeeURL = coffeeShop.url
            self.phoneNumber = coffeeShop.phoneNumber
            self.schedule = coffeeShop.formattedSchedule
            self.isFavourite = isFavourite
            self.distance = self.getDistance(coffeeShop.coordinate)
            self.isLoading = false
        }
    }

    private func getCoffeeShopsDetailsDidFail(_ error: RequestError) {
        DispatchQueue.main.async {
            self.error = error
            self.isLoading = false
        }
    }
}

extension CoffeeShopDetailsViewModel {

    func saveAsFavourite() {
        guard let coffeeShop else { return }
        let result = updateFavouriteCoffeeShop.execute(coffeeShop)

        switch result {
        case .success(let value):
            saveAsFavouriteDidSuccess(value: value)
        case .failure(let error):
            saveAsFavouriteDidFail(error)
        }
    }

    private func saveAsFavouriteDidSuccess(value: Bool) {
        DispatchQueue.main.async {
            self.isFavourite = value
        }
    }

    private func saveAsFavouriteDidFail(_ error: RequestError) {
        print("||DEBUG|| saveAsFavouriteDidFail - error: \(error.localizedDescription)")
    }
}

extension CoffeeShopDetailsViewModel {

    private func getDistance(_ coordinates: CLLocationCoordinate2D) -> String {
        let distanceToPlace = locationManager.getDistance(to: coordinates.latitude, longitude: coordinates.longitude)
        return getFormattedDistance(distanceToPlace)
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

    private func createCoordinateRegion(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate,
                           span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
