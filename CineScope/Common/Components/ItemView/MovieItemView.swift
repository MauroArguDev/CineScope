//
//  MovieItemView.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 26/12/24.
//

import SwiftUI

struct MovieItemView: View {
    let movie: Movie
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: movie.posterURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.3)
                        Image("imagePlaceholder")
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(width: 180, height: 250)
                .cornerRadius(12)
                .clipped()
                
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.textColor)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(height: 40)
                    .padding(.horizontal, 12)
            }
            .frame(width: 220, height: 320)
            .background(Color.primaryColor.opacity(0.5))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MovieItemView(movie: Movie(
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
