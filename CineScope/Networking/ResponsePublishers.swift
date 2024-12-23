//
//  ResponsePublishers.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Combine

typealias VoidPublisher = AnyPublisher<Void?, Error>
typealias MovieResponsePublisher = AnyPublisher<MovieResponse?, Error>
typealias GenreResponsePublisher = AnyPublisher<GenreResponse?, Error>
