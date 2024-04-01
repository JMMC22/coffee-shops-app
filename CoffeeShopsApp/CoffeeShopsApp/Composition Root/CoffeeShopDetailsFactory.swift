//
//  CoffeeShopDetailsFactory.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import Foundation

class CoffeeShopDetailsFactory {

    static func create(_ id: String) -> CoffeeShopDetailsView {
        return CoffeeShopDetailsView(viewModel: createViewModel(id))
    }

    private static func createViewModel(_ id: String) -> CoffeeShopDetailsViewModel {
        return CoffeeShopDetailsViewModel(id, getCoffeeShopDetails: createUseCase())
    }

    private static func createUseCase() -> GetCoffeeShopDetails {
        return DefaultGetCoffeeShopDetails(googlePlacesRepository: createRepository())
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
