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
        .navigationBarTitleDisplayMode(.inline)
        .toolbarRole(.editor)
        .task {
            await viewModel.getCoffeeShopsDetails()
        }
        .overlay(openWebsiteButton(), alignment: .bottom)
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
        .opacity(viewModel.coffeeURL != nil ? 1 : 0)
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
        VStack(spacing: 24) {
            image()
            information()
            staticMap()
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : .invalidated)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 54, trailing: 16))
    }

    private func image() -> some View {
        AsyncImage(url: viewModel.imageURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
                .clipped()
        } placeholder: {
            Color.customLightGrayText
        }
        .frame(height: 250)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func information() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            name()
            isOpen()
            informationItem(icon: "location", title: "Address", value: viewModel.address)
            informationItem(icon: "clock", title: "Hour", value: "viewModel.hour")
            informationItem(icon: "network", title: "Website", value: viewModel.coffeeURL?.absoluteString ?? "")
            informationItem(icon: "phone", title: "Phone Number", value: viewModel.phoneNumber)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func informationItem(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 4).fill(Color.customLightGrayText.opacity(0.4))
                .frame(width: 36, height: 36)
                .overlay {
                    Image(systemName: icon)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color.customDarkGrayText)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .CSFont(.inter(14, weight: .bold), color: .blackText)
                Text(value)
                    .CSFont(.inter(12, weight: .regular), color: .darkGrayText)
            }
        }
    }

    private func isOpen() -> some View {
        Text(viewModel.isOpenNow ? "Open" : "Closed")
            .CSFont(.inter(10, weight: .bold), color: .customWhite)
            .textCase(.uppercase)
            .padding(6)
            .background(viewModel.isOpenNow ? .greenOpen : .redClosed)
            .clipShape(Capsule())
    }

    private func name() -> some View {
        Text(viewModel.name)
            .CSFont(.inter(28, weight: .bold), color: .blackText)
    }

    private func staticMap() -> some View {
        Map(coordinateRegion: $viewModel.coordinate)
            .disabled(true)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
