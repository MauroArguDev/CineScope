//
//  SplashScreen.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 13/12/24.
//

import SwiftUI
import Lottie

struct SplashScreen: View {
    @StateObject private var viewModel = SplashViewModel()
    
    var body: some View {
        NavigationStack {
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
            .onAppear {
                viewModel.authenticate()
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("app_name"),
                    message: Text(viewModel.alertMessage ?? ""),
                    dismissButton: .default(Text("accept")) {
                        viewModel.resetAlert()
                    }
                )
            }
            .navigationDestination(isPresented: $viewModel.goDashboard) {
                DashboardScreen()
            }
        }
    }
}

#Preview {
    SplashScreen()
}
