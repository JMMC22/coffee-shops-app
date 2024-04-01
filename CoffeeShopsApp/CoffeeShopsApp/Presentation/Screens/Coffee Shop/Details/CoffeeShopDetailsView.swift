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

    @Environment(\.openURL) private var openURL

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
        .overlay(openWebsiteButton(), alignment: .bottom)
        .toolbar {
            Button(action: { open(URL(string: "tel://\(viewModel.phoneNumber)")) }) {
                Image(systemName: "phone.fill")
            }
        }
    }

    @ViewBuilder
    private func openWebsiteButton() -> some View {
        Button(action: { open(viewModel.coffeeURL) }) {
            Text("Go to website")
                .CSFont(.inter(14, weight: .bold), color: .whiteCustom)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .foregroundStyle(.whiteCustom)
        .background(.oliveGreen)
        .buttonBorderShape(.capsule)
    }
    
    private func open(_ url: URL?) {
        guard let url else { return }
        openURL(url)
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
            favourite()
            information()
            staticMap()
        }
    }

    private func image() -> some View {
        AsyncImage(url: viewModel.imageURL) { image in
            image
                .resizable()
                .frame(height: 350)
                // .clipped()
        } placeholder: {
            ProgressView()
        }
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

    private func favourite() -> some View {
        HStack {
            Spacer()
            Button(action: viewModel.saveAsFavourite) {
                Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                    .frame(width: 25, height: 25)
            }
        }
    }

    private func staticMap() -> some View {
        Map(coordinateRegion: $viewModel.coordinate)
            .disabled(true)
            .frame(height: 200)
    }
}
