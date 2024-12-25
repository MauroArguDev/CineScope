//
//  SearchableItemView.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 25/12/24.
//

import SwiftUI

struct SearchableItemView: View {
    let movie: Movie
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: movie.backdropURL)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.3)
                        Image("imagePlaceholder")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 120, height: 90)
                .cornerRadius(8)
                .clipped()
                
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.textColor)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.textColor)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.backgroundColor)
            .contentShape(Rectangle())
        }
        
    }
}

#Preview {
    SearchableItemView(movie: Movie(
        id: 0,
        title: "Jake Paul vs. Mike Tyson",
        overview: "The Problem Child, Jake 'El Gallo' Paul, goes up against the Baddest Man on the Planet, Mike Tyson, live from the AT&T Stadium in Arlington, Texas. Katie Taylor defends her undisputed title over 10, two-minute rounds against boxing trailblazer and unified featherweight world champion Amanda 'The Real Deal' Serrano in the most anticipated rematch in women's boxing history.",
        releaseDate: "2024-11-15",
        backdropPath: "/fKHJikRdF003w0GI16VrSg4mL0K.jpg",
        posterPath: "/dZqlRhJBcuHNQgoxC8phKgWC6W8.jpg",
        genreIds: [28],
        voteAverage: 6.2,
        voteCount: 22)) { }
}
