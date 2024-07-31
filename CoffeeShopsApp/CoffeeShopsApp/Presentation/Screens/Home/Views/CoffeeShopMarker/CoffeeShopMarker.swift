//
//  CoffeeShopMarker.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 31/7/24.
//

import SwiftUI

struct CoffeeShopMarker: View {

    @StateObject private var viewModel: CoffeeShopMarkerViewModel

    init(id: String) {
        self._viewModel = StateObject(wrappedValue: CoffeeShopMarkerViewModel(id: id))
    }

    var body: some View {
        Image("coffee-cup")
            .resizable()
            .frame(width: 18, height: 30)
            .padding(12)
            .background(Color.customOliveGreen)
            .clipShape(Circle())
    }
}
