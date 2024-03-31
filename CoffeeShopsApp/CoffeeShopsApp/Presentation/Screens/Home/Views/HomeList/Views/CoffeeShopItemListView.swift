//
//  CoffeeShopItemListView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import SwiftUI

struct CoffeeShopItemListView: View {

    let place: Place

    init(place: Place) {
        self.place = place
    }

    private var statusColor: Color {
        place.isOpen ? .customGreenOpen : .customRedClosed
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                icon()
                name()
                Spacer()
                info()
            }
            Divider()
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
    
    private func name() -> some View {
        Text(place.name)
            .CSFont(.inter(14, weight: .medium), color: .blackText)
    }
    
    private func info() -> some View {
        VStack {
            Text(place.isOpen ? "Open" : "Closed")
                .CSFont(.inter(10, weight: .bold), color: .customWhite)
                .textCase(.uppercase)
                .padding(6)
                .background(statusColor)
                .clipShape(Capsule())
        }
    }
}
