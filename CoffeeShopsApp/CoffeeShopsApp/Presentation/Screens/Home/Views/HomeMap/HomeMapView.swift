//
//  HomeMapView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 30/3/24.
//

import Foundation
import SwiftUI
import MapKit

struct HomeMapView: View {

    @ObservedObject var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map {
                ForEach(viewModel.nearbyCoffeeShops) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        markerIcon()
                            .onTapGesture { viewModel.navigateToPlaceDetails(id: location.id) }
                    }
                }
            }

            Button { viewModel.navigateToFavourites() } label: {
                Image("favourite-heart")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .padding(12)
                    .background(Color.coffee)
                    .clipShape(Circle())
            }
            .padding(16)
        }
    }

    private func markerIcon() -> some View {
        Image("coffee-cup")
            .resizable()
            .frame(width: 18, height: 30)
            .padding(12)
            .background(Color.customOliveGreen)
            .clipShape(Circle())
    }
}
