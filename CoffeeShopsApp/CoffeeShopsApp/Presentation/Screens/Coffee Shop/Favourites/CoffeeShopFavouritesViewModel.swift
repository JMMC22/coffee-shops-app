//
//  CoffeeShopFavouritesViewModel.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

class CoffeeShopFavouritesViewModel: ObservableObject {
    
    @Published var favouritesCoffeeShops: [Place] = []
    @Published var nextPage: AppCoordinator.Page?

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
            fetchFavouritesCoffeeShopsDidSuccess(list)
        case .failure(let error):
            print("||DEBUG|| getFavouritesCoffeeShops error: \(error.localizedDescription)")
        }
    }

    private func fetchFavouritesCoffeeShopsDidSuccess(_ places: [Place]) {
        DispatchQueue.main.async {
            self.favouritesCoffeeShops = places
        }
    }
}

extension CoffeeShopFavouritesViewModel {

    func navigateToPlaceDetails(id: String) {
        nextPage = .coffeShopDetails(id: id)
    }
}
