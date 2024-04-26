//
//  ContentView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 29/3/24.
//

import SwiftUI

struct ContentView: View {

    @State var splashAnimationEnded: Bool = false

    var body: some View {
        if splashAnimationEnded {
            AppCoordinatorView(rootPage: .home)
        } else {
            SplashView(animationEnded: $splashAnimationEnded)
        }
    }
}

#Preview {
    ContentView()
}
