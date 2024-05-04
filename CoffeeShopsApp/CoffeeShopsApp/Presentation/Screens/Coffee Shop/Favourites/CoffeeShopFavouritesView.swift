//
//  CoffeeShopFavouritesView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import SwiftUI

struct CoffeeShopFavouritesView: View {

    @StateObject private var viewModel: CoffeeShopFavouritesViewModel

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
                CoffeeShopItemListView(place: place)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(16)
    }
}

