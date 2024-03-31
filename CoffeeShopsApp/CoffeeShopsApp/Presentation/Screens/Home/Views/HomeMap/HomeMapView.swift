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
        Map {
            ForEach(viewModel.nearbyCoffeeShops) { location in
                Annotation(location.name, coordinate: location.coordinate) {
                    markerIcon()
                        .onTapGesture { viewModel.navigateToPlaceDetails(location) }
                }
            }
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
