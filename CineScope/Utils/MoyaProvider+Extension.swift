//
//  MoyaProvider+Extension.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Moya
import Combine

extension MoyaProvider {
    func requestPublisher(_ target: Target) -> AnyPublisher<Response, MoyaError> {
        return Future<Response, MoyaError> { [weak self] promise in
            self?.request(target) { result in
                switch result {
                case .success(let response):
                    promise(.success(response))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
