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
        ZStack(alignment: .bottomTrailing) {
            Map(initialPosition: .automatic) {
                ForEach(viewModel.nearbyCoffeeShops) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        markerIcon(id: location.id)
                            .onTapGesture { viewModel.navigateToPlaceDetails(id: location.id) }
                    }
                }

                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
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

    private func markerIcon(id: String) -> some View {
        CoffeeShopMarker(id: id)
    }
}
