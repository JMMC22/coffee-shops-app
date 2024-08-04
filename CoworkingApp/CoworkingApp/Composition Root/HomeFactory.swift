//
//  HomeFactory.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation

class HomeFactory {

    static func create() -> HomeView {
        return HomeView(viewModel: createViewModel())
    }

    private static func createViewModel() -> HomeViewModel {
        return HomeViewModel(getNearbyCoworkingSpaces: createUseCase())
    }

    private static func createUseCase() -> GetNearbyCoworkingSpaces {
        return DefaultGetNearbyCoworkingSpaces(googlePlacesRepository: createRepository())
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
