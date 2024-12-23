//
//  BaseService.swift
//  CineScope
//
//  Created by Mauricio Argumedo on 23/12/24.
//

import Foundation
import Moya

class BaseService {
    var provider = MoyaProvider<TMBDProvider>(
        plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
    )
}
