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

    @Published var name: String
    @Published var address: String
    @Published var isOpenNow: Bool
    @Published var coordinate: MKCoordinateRegion

    private let coffeeShop: Place

    init(_ coffeeShop: Place) {
        self.coffeeShop = coffeeShop
        self.name = coffeeShop.name
        self.address = coffeeShop.address
        self.isOpenNow = coffeeShop.isOpen
        self.coordinate = MKCoordinateRegion(center: coffeeShop.coordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
