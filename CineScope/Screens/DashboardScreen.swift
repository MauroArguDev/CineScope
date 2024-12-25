//
//  DashboardScreen.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 24/12/24.
//

import SwiftUI

struct DashboardScreen: View {
    @State var selection: Int = 1
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.text
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                FavoritesScreen()
                    .tabItem {
                        Label("favorites", systemImage: "heart.fill")
                    }.tag(0)
                
                HomeScreen()
                    .tabItem {
                        Label("home", systemImage: "house.fill")
                    }.tag(1)
                
                SettingsScreen()
                    .tabItem {
                        Label("settings", systemImage: "gear")
                    }.tag(2)
            }
            .tint(Color.primaryColor)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardScreen()
}
