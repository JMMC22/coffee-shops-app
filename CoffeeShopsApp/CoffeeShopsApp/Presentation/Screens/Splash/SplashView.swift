//
//  SplashView.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 25/4/24.
//

import SwiftUI

struct SplashView: View {
    
    @Binding var animationEnded: Bool

    // MARK: Wave aniamtion parameters
    @State private var percent = 0.0
    @State private var waveOffset = Angle(degrees: 0)

    // MARK: Timer parameters
    let totalTime: Double = 2
    let timerInterval: Double = 0.02

    var body: some View {
        ZStack {
            icon()
            wave()
        }
        .onAppear {
            waveAnimation()
            wavePercentCounter()
        }
    }

    private func icon() -> some View {
        Image("coffee-cup")
            .resizable()
            .frame(width: 90, height: 150)
            .padding(45)
            .background(Color.coffee)
            .clipShape(Circle())
    }

    private func wave() -> some View {
        Wave(offSet: Angle(degrees: waveOffset.degrees), percent: percent)
            .fill(Color.customCoffee)
            .ignoresSafeArea(.all)
    }

    private func waveAnimation() {
        withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
            self.waveOffset = Angle(degrees: 360)
        }
    }

    private func wavePercentCounter() {
        let timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { _ in
            if percent < 100 {
                percent += 100 * (timerInterval / totalTime)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + totalTime) {
            timer.invalidate()
            animationEnded = true
        }
    }
}
