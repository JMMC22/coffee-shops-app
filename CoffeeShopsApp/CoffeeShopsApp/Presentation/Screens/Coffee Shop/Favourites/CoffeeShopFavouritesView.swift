//
//  CoffeeShopFavouritesView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import SwiftUI

struct CoffeeShopFavouritesView: View {

    @StateObject private var viewModel: CoffeeShopFavouritesViewModel
    @EnvironmentObject private var coordinator: AppCoordinator

    init(viewModel: CoffeeShopFavouritesViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            CoffeeShopFavouritesContainer(viewModel: viewModel)
        }
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchFavouritesCoffeeShops()
        }
        .onReceive(viewModel.$nextPage) { newPage in
            if let newPage {
                coordinator.push(newPage)
            }
        }
    }
}

struct CoffeeShopFavouritesContainer: View {

    @ObservedObject private var viewModel: CoffeeShopFavouritesViewModel

    init(viewModel: CoffeeShopFavouritesViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(viewModel.favouritesCoffeeShops) { place in
                CoffeeShopItemListView(place: place) { id in
                    viewModel.navigateToPlaceDetails(id: id)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
    }
}

