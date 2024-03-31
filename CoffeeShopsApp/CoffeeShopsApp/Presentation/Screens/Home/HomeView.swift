//
//  HomeView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation
import SwiftUI
import MapKit

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject private var coordinator: AppCoordinator

    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        HomeContainerView(viewModel: viewModel)
            .onAppear {
                viewModel.viewDidLoad()
            }
            .onReceive(viewModel.$nextPage) { newPage in
                if let newPage {
                    coordinator.push(newPage)
                }
            }
    }
}

struct HomeContainerView: View {
    @ObservedObject var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HomeMapView(viewModel: viewModel)
                HomeListView(coffeeShops: viewModel.nearbyCoffeeShops)
                    .frame(height: geometry.size.height / 3)
            }
        }
    }
}
