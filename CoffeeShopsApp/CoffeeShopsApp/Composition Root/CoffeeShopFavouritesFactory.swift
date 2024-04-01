//
//  CoffeeShopFavouritesFactory.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

class CoffeeShopFavouritesFactory {

    static func create() -> CoffeeShopFavouritesView {
        return CoffeeShopFavouritesView(viewModel: createViewModel())
    }

    private static func createViewModel() -> CoffeeShopFavouritesViewModel {
        return CoffeeShopFavouritesViewModel()
    }
}
