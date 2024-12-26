//
//  TMBDProvider.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 15/12/24.
//

import Foundation
import Moya

enum TMBDProvider {
    case authentication
    case getPopularMovies(page: Int)
    case getTopRatedMovies(page: Int)
    case getNowPlayingMovies(page: Int)
    case getUpcomingMovies(page: Int)
    case searchMovie(includeAdult: Bool, query: String, page: Int)
    case getGenres
}

extension TMBDProvider: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .authentication:
            return "authentication"
        case .getPopularMovies:
            return "movie/popular"
        case .getTopRatedMovies:
            return "movie/top_rated"
        case .getNowPlayingMovies:
            return "movie/now_playing"
        case .getUpcomingMovies:
            return "movie/upcoming"
        case .searchMovie:
            return "search/movie"
        case .getGenres:
            return "genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        let language = Bundle.main.preferredLocalizations.first ?? "en"
        
        switch self {
        case .authentication, .getGenres:
            return .requestParameters(parameters: ["language": language], encoding: URLEncoding.queryString)
        case let .getPopularMovies(page):
            return .requestParameters(parameters: ["language": language, "page": page], encoding: URLEncoding.queryString)
        case let .getTopRatedMovies(page):
            return .requestParameters(parameters: ["language": language, "page": page], encoding: URLEncoding.queryString)
        case let .getNowPlayingMovies(page):
            return .requestParameters(parameters: ["language": language, "page": page], encoding: URLEncoding.queryString)
        case let .getUpcomingMovies(page):
            return .requestParameters(parameters: ["language": language, "page": page], encoding: URLEncoding.queryString)
        case let .searchMovie(includeAdult, query, page):
            return .requestParameters(parameters: ["language": language, "include_adult": includeAdult, "query": query, "page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        let key = ""
        let apiKey = "Bearer \(key)"
        
        return [
            "Content-Type": "application/json",
            "Authorization": apiKey
        ]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}

var language: String {
    if Bundle.main.preferredLocalizations.first == "es" || Bundle.main.preferredLocalizations.first == "en" {
        return Bundle.main.preferredLocalizations.first ?? "en"
    } else {
        return "en"
    }
}
