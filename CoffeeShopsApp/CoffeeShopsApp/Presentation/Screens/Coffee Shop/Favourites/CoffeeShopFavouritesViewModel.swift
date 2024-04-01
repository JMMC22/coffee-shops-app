//
//  CoffeeShopFavouritesViewModel.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

class CoffeeShopFavouritesViewModel: ObservableObject {

    private let getFavouritesCoffeeShops: GetFavouritesCoffeeShops

    init(getFavouritesCoffeeShops: GetFavouritesCoffeeShops) {
        self.getFavouritesCoffeeShops = getFavouritesCoffeeShops
    }
}

extension CoffeeShopFavouritesViewModel {
    func fetchFavouritesCoffeeShops() {
        let result = getFavouritesCoffeeShops.execute()
        
        switch result {
        case .success(let list):
            print("||DEBUG|| list count: \(list.count)")
        case .failure(let error):
            print("||DEBUG|| getFavouritesCoffeeShops error: \(error.localizedDescription)")
        }
    }
}
