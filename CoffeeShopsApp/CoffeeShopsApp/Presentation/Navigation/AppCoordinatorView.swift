//
//  AppCoordinatorView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation
import SwiftUI

struct AppCoordinatorView: View {

    @StateObject private var coordinator = AppCoordinator()
    let rootPage: AppCoordinator.Page

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: rootPage)
                .navigationDestination(for: AppCoordinator.Page.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.presentedItem) { sheet in
                    coordinator.build(page: sheet)
                }
        }
        .tint(.customCoffee)
        .environmentObject(coordinator)
    }
}
