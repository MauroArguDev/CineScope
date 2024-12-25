//
//  SettingsScreen.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 24/12/24.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            Text("settings")
                .foregroundStyle(Color.textColor)
        }
    }
}

#Preview {
    SettingsScreen()
}
