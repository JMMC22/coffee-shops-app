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
        return CoffeeShopFavouritesViewModel(getFavouritesCoffeeShops: createGetFavouritesUseCase())
    }

    private static func createGetFavouritesUseCase() -> GetFavouritesCoffeeShops {
        return DefaultGetFavouritesCoffeeShops(googlePlacesRepository: createRepository())
    }

    private static func createRepository() -> GooglePlacesRepository {
        return DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: createDatasource(),
                                             googlePlacesUserDefaultsDatasource: createPersistanceDatasource())
    }

    private static func createDatasource() -> GooglePlacesRemoteDatasource {
        let client = NetworkManager()
        return DefaultGooglePlacesRemoteDatasource(httpClient: client)
    }

    private static func createPersistanceDatasource() -> GooglePlacesUserDefaultsDatasource {
        let client = UserDefaultManager.shared
        return DefaultGooglePlacesUserDefaultsDatasource(userDefaultsManager: client)
    }
}
