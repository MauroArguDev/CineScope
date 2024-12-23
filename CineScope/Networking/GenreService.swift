//
//  GenreService.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation
import Moya

protocol GenreServiceProtocol {
    func getGenres() -> GenreResponsePublisher
}

class GenreService: BaseService, GenreServiceProtocol {
    func getGenres() -> GenreResponsePublisher {
        provider.requestPublisher(.getGenres)
            .tryMap { response in
                guard response.statusCode < 300 else {
                    throw try response.decodeAPIError()
                }
                return response.data
            }
            .decode(type: GenreResponse.self, decoder: JSONDecoder())
            .map { Optional($0) }
            .mapToAPIError()
            .eraseToAnyPublisher()
    }
}
