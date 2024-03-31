//
//  HomeListView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import SwiftUI

struct HomeListView: View {

    let coffeeShops: [Place]

    init(coffeeShops: [Place]) {
        self.coffeeShops = coffeeShops
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(coffeeShops) { place in
                    CoffeeShopItemListView(place: place)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(16)
        }
        .scrollIndicators(.hidden)
    }
}
