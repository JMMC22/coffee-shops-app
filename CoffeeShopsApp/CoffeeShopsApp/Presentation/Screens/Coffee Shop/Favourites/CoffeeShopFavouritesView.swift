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
        Text("Favourite View")
            .onAppear {
                viewModel.fetchFavouritesCoffeeShops()
            }
    }
}
