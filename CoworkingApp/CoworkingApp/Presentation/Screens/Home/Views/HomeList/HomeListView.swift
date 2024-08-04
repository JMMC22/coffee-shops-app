//
//  HomeListView.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import SwiftUI

struct HomeListView: View {

    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.nearbyCoworkingSpaces) { place in
                    CoworkingSpaceItemListView(place: place) { id in
                        viewModel.navigateToPlaceDetails(id: id)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(16)
        }
        .scrollIndicators(.hidden)
    }
}
