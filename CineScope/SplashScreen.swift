//
//  ContentView.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 13/12/24.
//

import SwiftUI
import Lottie

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Color.backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                LottieView(animation: .named("splash"))
                    .playing(loopMode: .playOnce)
                    .animationSpeed(1.2)
            }
            .padding()
        }
    }
}

#Preview {
    SplashScreen()
}
