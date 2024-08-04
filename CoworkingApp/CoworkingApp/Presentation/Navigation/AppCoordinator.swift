//
//  AppCoordinator.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation
import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var presentedItem: AppCoordinator.Page?
}

extension AppCoordinator {
    enum Page: Hashable, Identifiable {
        case home
        case coworkingSpaceDetails(id: String)
        case favouritesCoworkingSpaces

        var id: String {
            String(describing: self)
        }
    }

    // MARK: - Navigate
    func push(_ page: AppCoordinator.Page) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    // MARK: - Sheet
    func present(_ page: AppCoordinator.Page) {
        presentedItem = page
    }

    func dismissSheet() {
        self.presentedItem = nil
    }

    @ViewBuilder
    func build(page: AppCoordinator.Page) -> some View {
        switch page {
        case .home:
            HomeFactory.create()
        case .coworkingSpaceDetails(let id):
            CoworkingSpaceDetailsFactory.create(id)
        case .favouritesCoworkingSpaces:
            CoworkingSpacesFavouritesFactory.create()
        }
    }
}
