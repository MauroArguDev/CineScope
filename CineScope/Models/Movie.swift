//
//  Movie.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 15/12/24.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String?
    let backdropPath: String?
    let posterPath: String?
    let genreIds: [Int]?
    let voteAverage: Double?
    let voteCount: Int?
    var adult: Bool? = false
    
    var backdropURL: URL {
        guard let backdropPath else { return URL(string: "")! }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath)")!
    }
    
    var posterURL: URL {
        guard let posterPath else { return URL(string: "")! }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")!
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
