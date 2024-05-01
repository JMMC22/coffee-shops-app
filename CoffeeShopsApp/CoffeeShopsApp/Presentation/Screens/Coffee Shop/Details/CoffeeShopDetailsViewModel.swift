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
    @Published var imageURL: URL?
    @Published var schedule: String = ""

    @Published var isLoading: Bool = true
    @Published var error: RequestError?

    // MARK: External
    var coffeeURL: URL?
    var phoneNumber: String = ""

    private let getCoffeeShopDetails: GetCoffeeShopDetails
    private let id: String

    init(_ id: String, getCoffeeShopDetails: GetCoffeeShopDetails) {
        self.id = id
        self.getCoffeeShopDetails = getCoffeeShopDetails
    }
}

extension CoffeeShopDetailsViewModel {

    func getCoffeeShopsDetails() async {
        let result = await getCoffeeShopDetails.getCoffeeShopDetails(id: id)

        switch result {
        case .success(let coffeeShop):
            getCoffeeShopsDetailsDidSuccess(coffeeShop)
        case .failure(let error):
            getCoffeeShopsDetailsDidFail(error)
        }
    }

    private func getCoffeeShopsDetailsDidSuccess(_ coffeeShop: Place) {
        DispatchQueue.main.async {
            self.name = coffeeShop.name
            self.address = coffeeShop.address
            self.isOpenNow = coffeeShop.isOpen
            self.coordinate = self.createCoordinateRegion(coffeeShop.coordinate)
            self.imageURL = coffeeShop.photos.first?.getPlacePhotoURL()
            self.coffeeURL = coffeeShop.url
            self.phoneNumber = coffeeShop.phoneNumber
            self.schedule = coffeeShop.formattedSchedule
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
    private func createCoordinateRegion(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate,
                           span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
