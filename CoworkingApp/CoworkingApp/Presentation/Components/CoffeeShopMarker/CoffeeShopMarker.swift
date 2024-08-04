//
//  CoffeeShopMarker.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import SwiftUI

struct CoffeeShopMarker: View {

    let isFavourite: Bool

    init(isFavourite: Bool) {
        self.isFavourite = isFavourite
    }

    var body: some View {
        Image("coffee-cup")
            .resizable()
            .frame(width: 18, height: 30)
            .padding(12)
            .background(isFavourite ? Color.customCoffee : Color.customOliveGreen)
            .clipShape(Circle())
    }
}
