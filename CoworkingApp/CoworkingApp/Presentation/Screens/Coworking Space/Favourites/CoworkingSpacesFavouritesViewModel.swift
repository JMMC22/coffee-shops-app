//
//  CoworkingSpaceFavouritesViewModel.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import Foundation

class CoworkingSpacesFavouritesViewModel: ObservableObject {
    
    @Published var favouritesCoworkingSpaces: [Place] = []
    @Published var nextPage: AppCoordinator.Page?

    private let getFavouritesCoworkingSpaces: GetFavouritesCoworkingSpaces

    init(getFavouritesCoworkingSpaces: GetFavouritesCoworkingSpaces) {
        self.getFavouritesCoworkingSpaces = getFavouritesCoworkingSpaces
    }
}

extension CoworkingSpacesFavouritesViewModel {
    func fetchFavouritesCoworkingSpaces() {
        let result = getFavouritesCoworkingSpaces.execute()
        
        switch result {
        case .success(let list):
            fetchFavouritesCoworkingSpacesDidSuccess(list)
        case .failure(let error):
            print("||DEBUG|| fetchFavouritesCoworkingSpaces error: \(error.localizedDescription)")
        }
    }

    private func fetchFavouritesCoworkingSpacesDidSuccess(_ places: [Place]) {
        DispatchQueue.main.async {
            self.favouritesCoworkingSpaces = places
        }
    }
}

extension CoworkingSpacesFavouritesViewModel {

    func navigateToPlaceDetails(id: String) {
        nextPage = .coworkingSpaceDetails(id: id)
    }
}
