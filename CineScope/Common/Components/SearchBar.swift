//
//  SearchBar.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 24/12/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.gray)
                
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text("search")
                            .foregroundColor(Color.textColor)
                    }
                    
                    TextField("", text: $text, onEditingChanged: { _ in
                        onSearch()
                    })
                    .foregroundColor(Color.textColor)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .focused($isFocused)
                }
            }
            .padding(10)
            .background(Color.backgroundColor)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
            
            if isFocused {
                Button(action: {
                    text = ""
                    isFocused = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.textColor)
                        .transition(.opacity.combined(with: .scale))
                }
            }
        }
    }
}

#Preview {
    SearchBar(text: .constant("")) { }
}
