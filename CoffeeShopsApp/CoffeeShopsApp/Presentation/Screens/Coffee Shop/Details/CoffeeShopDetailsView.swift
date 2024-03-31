//
//  CoffeeShopDetailsView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import SwiftUI
import MapKit

struct CoffeeShopDetailsView: View {

    @StateObject private var viewModel: CoffeeShopDetailsViewModel

    init(viewModel: CoffeeShopDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            CoffeeShopDetailsContainerView(viewModel: viewModel)
        }
        .navigationTitle(viewModel.name)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getCoffeeShopsDetails()
        }
    }
}

struct CoffeeShopDetailsContainerView: View {

    @ObservedObject private var viewModel: CoffeeShopDetailsViewModel

    init(viewModel: CoffeeShopDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            image()
            information()
            staticMap()
        }
    }

    private func image() -> some View {
        Rectangle()
            .fill(.darkGrayText)
            .frame(height: 350)
    }

    private func information() -> some View {
        VStack {
            Text(viewModel.address)
                .CSFont(.inter(14, weight: .regular), color: .blackText)
            Text(viewModel.isOpenNow ? "Open Now" : "Closed")
                .CSFont(.inter(14, weight: .regular), color: viewModel.isOpenNow ? .greenOpen : .redClosed)
        }
    }

    private func staticMap() -> some View {
        Map(coordinateRegion: $viewModel.coordinate)
            .disabled(true)
            .frame(height: 200)
    }
}
