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

    private let getCoffeeShopDetails: GetCoffeeShopDetails
    private let id: String

    init(_ id: String, getCoffeeShopDetails: GetCoffeeShopDetails) {
        self.id = id
        self.getCoffeeShopDetails = getCoffeeShopDetails
    }
}
