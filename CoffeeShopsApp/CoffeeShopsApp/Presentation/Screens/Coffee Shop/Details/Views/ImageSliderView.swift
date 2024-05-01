//
//  ImageSliderView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 2/5/24.
//

import SwiftUI

struct ImageSliderView: View {

    private let imagesURLs: [URL?]

    init(imagesURLs: [URL?]) {
        self.imagesURLs = imagesURLs
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack {
                    ForEach(imagesURLs, id: \.?.absoluteString) { imageURL in
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width * 0.9, height: 200)
                                .clipped()
                        } placeholder: {
                            Color.customLightGrayText
                        }
                        .frame(width: geometry.size.width * 0.9, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
        }
        .frame(height: 200)
    }
}
