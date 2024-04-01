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
    @Published var isFavourite: Bool = false

    @Published var error: RequestError?

    // MARK: External
    var coffeeURL: URL?
    var phoneNumber: String = ""

    private let getCoffeeShopDetails: GetCoffeeShopDetails
    private let saveFavouriteCoffeeShop: SaveFavouriteCoffeeShop

    private let id: String
    private var coffeeShop: Place?

    init(_ id: String, getCoffeeShopDetails: GetCoffeeShopDetails, saveFavouriteCoffeeShop: SaveFavouriteCoffeeShop) {
        self.id = id
        self.getCoffeeShopDetails = getCoffeeShopDetails
        self.saveFavouriteCoffeeShop = saveFavouriteCoffeeShop
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
        self.coffeeShop = coffeeShop
        DispatchQueue.main.async {
            self.name = coffeeShop.name
            self.address = coffeeShop.address
            self.isOpenNow = coffeeShop.isOpen
            self.coordinate = self.createCoordinateRegion(coffeeShop.coordinate)
            self.imageURL = coffeeShop.photos.first?.getPlacePhotoURL()
            self.coffeeURL = coffeeShop.url
            self.phoneNumber = coffeeShop.phoneNumber
        }
    }

    private func getCoffeeShopsDetailsDidFail(_ error: RequestError) {
        DispatchQueue.main.async {
            self.error = error
        }
    }
}

extension CoffeeShopDetailsViewModel {

    func saveAsFavourite() {
        guard let coffeeShop else { return }
        let result = saveFavouriteCoffeeShop.execute(coffeeShop)

        switch result {
        case .success:
            saveAsFavouriteDidSuccess()
        case .failure(let error):
            saveAsFavouriteDidFail(error)
        }
    }

    private func saveAsFavouriteDidSuccess() {
        DispatchQueue.main.async {
            self.isFavourite = true
        }
    }

    private func saveAsFavouriteDidFail(_ error: RequestError) {
        print("||DEBUG|| saveAsFavouriteDidFail - error: \(error.localizedDescription)")
    }
}

extension CoffeeShopDetailsViewModel {
    private func createCoordinateRegion(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate,
                           span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
