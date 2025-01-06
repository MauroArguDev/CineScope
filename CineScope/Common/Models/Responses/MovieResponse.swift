//
//  MovieResponse.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
