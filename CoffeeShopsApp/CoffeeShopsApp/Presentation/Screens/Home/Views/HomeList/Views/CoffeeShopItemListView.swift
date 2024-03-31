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

    var body: some View {
        Text(place.name)
    }
}
