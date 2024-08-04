//
//  CoffeeShopDetailsFactory.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import Foundation

class CoworkingSpaceDetailsFactory {

    static func create(_ id: String) -> CoworkingSpaceDetailsView {
        return CoworkingSpaceDetailsView(viewModel: createViewModel(id))
    }

    private static func createViewModel(_ id: String) -> CoworkingSpaceDetailsViewModel {
        return CoworkingSpaceDetailsViewModel(id, getCoffeeShopDetails: createUseCase(),
                                          updateFavouriteCoffeeShop: createUpdateFavouriteUseCase(),
                                          isFavouriteCoffeeShop: isFavouriteUseCase())
    }

    private static func createUseCase() -> GetCoworkingSpaceDetails {
        return DefaultGetCoworkingSpaceDetails(googlePlacesRepository: createRepository())
    }

    private static func createUpdateFavouriteUseCase() -> UpdateFavouriteCoworkingSpace {
        return DefaultUpdateFavouriteCoworkingSpace(googlePlacesRepository: createRepository())
    }

    private static func isFavouriteUseCase() -> IsFavouriteCoworkingSpace {
        return DefaultIsFavouriteCoworkingSpace(googlePlacesRepository: createRepository())
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
