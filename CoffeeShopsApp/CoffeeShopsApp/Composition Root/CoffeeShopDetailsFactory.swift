//
//  CoffeeShopDetailsFactory.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import Foundation

class CoffeeShopDetailsFactory {

    static func create(_ coffeShop: Place) -> CoffeeShopDetailsView {
        return CoffeeShopDetailsView(viewModel: createViewModel(coffeShop))
    }

    private static func createViewModel(_ coffeShop: Place) -> CoffeeShopDetailsViewModel {
        return CoffeeShopDetailsViewModel(coffeShop)
    }
}
