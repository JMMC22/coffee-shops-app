//
//  CoffeeShopItemListView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import SwiftUI

struct CoffeeShopItemListView: View {

    @StateObject private var viewModel: CoffeeShopItemListViewModel
    let action: (String) -> Void

    init(place: Place, action: @escaping (String) -> Void) {
        self._viewModel = StateObject(wrappedValue: CoffeeShopItemListViewModel(place: place))
        self.action = action
    }

    private var statusColor: Color {
        viewModel.place.isOpen ? .customGreenOpen : .customRedClosed
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                icon()
                info()
                Spacer()
                isOpen()
            }
            Divider()
        }.onTapGesture {
            action(viewModel.place.id)
        }
        .onAppear {
            viewModel.getDistance()
        }
    }

    private func icon() -> some View {
        Image("coffee-cup")
            .resizable()
            .frame(width: 18, height: 30)
            .padding(12)
            .background(Color.customOliveGreen)
            .clipShape(Circle())
    }
    
    private func info() -> some View {
        VStack(alignment: .leading) {
            Text(viewModel.place.name)
                .CSFont(.inter(14, weight: .medium), color: .blackText)
            Text(viewModel.distance)
                .CSFont(.inter(12, weight: .regular), color: .darkGrayText)
        }
    }
    
    private func isOpen() -> some View {
        VStack {
            Text(viewModel.place.isOpen ?  "coffee.shop.open" : "coffee.shop.closed")
                .CSFont(.inter(10, weight: .bold), color: .customWhite)
                .textCase(.uppercase)
                .padding(6)
                .background(statusColor)
                .clipShape(Capsule())
        }
    }
}
