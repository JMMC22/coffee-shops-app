//
//  AppCoordinator.swift
//  CoffeeShopsApp
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
        case coffeShopDetails(_ coffeShop: Place)
        case favouritesCoffeeShops

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
        case .coffeShopDetails(let coffeeShop):
            Text("Details")
        case .favouritesCoffeeShops:
            Text("Favourites Coffee Shops View")
        }
    }
}
