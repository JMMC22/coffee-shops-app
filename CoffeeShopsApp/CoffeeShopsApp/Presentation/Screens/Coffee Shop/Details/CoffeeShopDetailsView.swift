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

    @State private var showAppsSelector: Bool = false

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
        .overlay(openNavigatorButton(), alignment: .bottom)
        .actionSheet(isPresented: $showAppsSelector) {
            ActionSheet(
                title: Text("action.sheet.open.in"),
                message: nil,
                buttons: getDirectionApps()
            )
        }
    }

    @ViewBuilder
    private func openNavigatorButton() -> some View {
        Button(action: { showAppsSelector = true }) {
            Text("button.go.place")
                .CSFont(.inter(14, weight: .bold), color: .whiteCustom)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .foregroundStyle(.whiteCustom)
        .background(.oliveGreen)
        .buttonBorderShape(.capsule)
        .opacity(viewModel.coffeeURL != nil ? 1 : 0)
    }

    private func getDirectionApps() -> [ActionSheet.Button] {
        let buttons: [ActionSheet.Button] = MapApp.availableApps.map { navigationApp in
            ActionSheet.Button.default(
                Text(navigationApp.appName),
                action: {
                    navigateToApp(navigationApp)
                }
            )
        }
        
        let cancelAction = ActionSheet.Button.cancel(Text("action.sheet.dismiss"))

        return buttons + [cancelAction]
    }
    
    private func navigateToApp(_ app: MapApp) {
        guard let url = viewModel.getMapAppURL(app) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}

struct CoffeeShopDetailsContainerView: View {

    @ObservedObject private var viewModel: CoffeeShopDetailsViewModel
    @Environment(\.openURL) private var openURL

    init(viewModel: CoffeeShopDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 24) {
            imageSlider()
            information()
            staticMap()
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : .invalidated)
    }

    @ViewBuilder
    private func imageSlider() -> some View {
        if !viewModel.imagesURLs.isEmpty {
            ImageSliderView(imagesURLs: viewModel.imagesURLs)
        }
    }

    private func information() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            name()

            HStack {
                isOpen()
                Spacer()
                favourite()
            }

            informationItem(icon: "location", title: "coffee.shop.address", 
                            value: viewModel.address)
            informationItem(icon: "clock", title: "coffee.shop.hour", 
                            value: viewModel.schedule)
            informationItem(icon: "network", title: "coffee.shop.website",
                            value: viewModel.coffeeURL?.absoluteString ?? "", isLink: true)
            informationItem(icon: "phone", title: "coffee.shop.phone.number", 
                            value: viewModel.phoneNumber)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 54, trailing: 16))
    }

    @ViewBuilder
    private func informationItem(icon: String, title: String, value: String, isLink: Bool = false) -> some View {
        if !value.isEmpty {
            HStack(alignment: .top, spacing: 8) {
                RoundedRectangle(cornerRadius: 4).fill(Color.customLightGrayText.opacity(0.4))
                    .frame(width: 36, height: 36)
                    .overlay {
                        Image(systemName: icon)
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(Color.customDarkGrayText)
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(LocalizedStringKey(title))
                        .CSFont(.inter(14, weight: .bold), color: .blackText)

                    if isLink, let url = URL(string: value) {
                        Text(url.host() ?? value)
                            .CSFont(.inter(12, weight: .regular), color: .darkGrayText)
                            .underline()
                            .onTapGesture {
                                open(url)
                            }
                    } else {
                        Text(value)
                            .CSFont(.inter(12, weight: .regular), color: .darkGrayText)
                    }
                }
            }
        }
    }

    private func isOpen() -> some View {
        HStack {
            Text(viewModel.isOpenNow ? "coffee.shop.open" : "coffee.shop.closed")
                .CSFont(.inter(10, weight: .bold), color: .customWhite)
                .textCase(.uppercase)
                .padding(6)
                .background(viewModel.isOpenNow ? .greenOpen : .redClosed)
                .clipShape(Capsule())

            Text(viewModel.distance)
                .CSFont(.inter(14, weight: .bold), color: .darkGrayText)
        }
    }

    private func name() -> some View {
        Text(viewModel.name)
            .CSFont(.inter(28, weight: .bold), color: .blackText)
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
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 54, trailing: 16))
    }
    
    private func open(_ url: URL?) {
        guard let url else { return }
        openURL(url)
    }
}
