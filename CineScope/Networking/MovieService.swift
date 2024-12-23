//
//  MovieService.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation
import Moya

protocol MovieServiceProtocol {
    func getPopularMovies(page: Int) -> MovieResponsePublisher
    func getTopRatedMovies(page: Int) -> MovieResponsePublisher
    func getNowPlayingMovies(page: Int) -> MovieResponsePublisher
    func getUpcomingMovies(page: Int) -> MovieResponsePublisher
    func searchMovies(includeAdult: Bool, query: String, page: Int) -> MovieResponsePublisher
}

class MovieService: BaseService, MovieServiceProtocol {
    func getPopularMovies(page: Int) -> MovieResponsePublisher {
        return provider.requestPublisher(.getPopularMovies(page: page))
            .tryMap { response in
                guard response.statusCode < 300 else {
                    throw try response.decodeAPIError()
                }
                return response.data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .mapToAPIError()
            .eraseToAnyPublisher()
    }
    
    func getTopRatedMovies(page: Int) -> MovieResponsePublisher {
        return provider.requestPublisher(.getTopRatedMovies(page: page))
            .tryMap { response in
                guard response.statusCode < 300 else {
                    throw try response.decodeAPIError()
                }
                return response.data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .mapToAPIError()
            .eraseToAnyPublisher()
    }
    
    func getNowPlayingMovies(page: Int) -> MovieResponsePublisher {
        return provider.requestPublisher(.getNowPlayingMovies(page: page))
            .tryMap { response in
                guard response.statusCode < 300 else {
                    throw try response.decodeAPIError()
                }
                return response.data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .mapToAPIError()
            .eraseToAnyPublisher()
    }
    
    func getUpcomingMovies(page: Int) -> MovieResponsePublisher {
        return provider.requestPublisher(.getUpcomingMovies(page: page))
            .tryMap { response in
                guard response.statusCode < 300 else {
                    throw try response.decodeAPIError()
                }
                return response.data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .mapToAPIError()
            .eraseToAnyPublisher()
    }
    
    func searchMovies(includeAdult: Bool, query: String, page: Int) -> MovieResponsePublisher {
        return provider.requestPublisher(.searchMovie(includeAdult: includeAdult, query: query, page: page))
            .tryMap { response in
                guard response.statusCode < 300 else {
                    throw try response.decodeAPIError()
                }
                return response.data
            }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .mapToAPIError()
            .eraseToAnyPublisher()
    }
}
