//
//  CoworkingSpaceFavouritesFactory.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

class CoworkingSpacesFavouritesFactory {

    static func create() -> CoworkingSpacesFavouritesView {
        return CoworkingSpacesFavouritesView(viewModel: createViewModel())
    }

    private static func createViewModel() -> CoworkingSpacesFavouritesViewModel {
        return CoworkingSpacesFavouritesViewModel(getFavouritesCoworkingSpaces: createGetFavouritesUseCase())
    }

    private static func createGetFavouritesUseCase() -> GetFavouritesCoworkingSpaces {
        return DefaultGetFavouritesCoworkingSpaces(googlePlacesRepository: createRepository())
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
