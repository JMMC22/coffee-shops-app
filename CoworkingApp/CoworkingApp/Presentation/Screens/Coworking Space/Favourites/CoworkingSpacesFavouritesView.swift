//
//  CoworkingSpaceFavouritesView.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 1/4/24.
//

import SwiftUI

struct CoworkingSpacesFavouritesView: View {

    @StateObject private var viewModel: CoworkingSpacesFavouritesViewModel
    @EnvironmentObject private var coordinator: AppCoordinator

    init(viewModel: CoworkingSpacesFavouritesViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            CoworkingSpacesFavouritesContainer(viewModel: viewModel)
        }
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchFavouritesCoworkingSpaces()
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

struct CoworkingSpacesFavouritesContainer: View {

    @ObservedObject private var viewModel: CoworkingSpacesFavouritesViewModel

    init(viewModel: CoworkingSpacesFavouritesViewModel) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            title()
            ForEach(viewModel.favouritesCoworkingSpaces) { place in
                CoworkingSpaceItemListView(place: place) { id in
                    viewModel.navigateToPlaceDetails(id: id)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }

    private func title() -> some View {
        Text("favourites")
            .CSFont(.inter(28, weight: .bold), color: .blackText)
    }
}

