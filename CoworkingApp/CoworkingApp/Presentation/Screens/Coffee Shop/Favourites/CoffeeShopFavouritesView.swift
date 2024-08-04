//
//  CoffeeShopFavouritesView.swift
//  CoworkingApp
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
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
    }
}

struct CoffeeShopFavouritesContainer: View {

    @ObservedObject private var viewModel: CoffeeShopFavouritesViewModel

    init(viewModel: CoffeeShopFavouritesViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            title()
            ForEach(viewModel.favouritesCoffeeShops) { place in
                CoffeeShopItemListView(place: place) { id in
                    viewModel.navigateToPlaceDetails(id: id)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }

    private func title() -> some View {
        Text("favourites")
            .CSFont(.inter(28, weight: .bold), color: .blackText)
    }
}

