//
//  Endpoint.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

enum Endpoint {

    private enum HTTPMettod: String {
        case get
        case put
        case post
        case delete
    }

    private var baseURL: URL {
        guard let baseURL = URL(string: "https://breakingbadapi.com/api/") else {
            fatalError("baseURL is invalid")
        }

        return baseURL
    }

    private var method: HTTPMettod {
        switch self {
        case .getCharacters:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .getCharacters:
            return "characters"
        }
    }

    func asUrlRequest() throws -> URLRequest {
        guard let requestURL = URL(string: baseURL.appendingPathComponent(path).absoluteString) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue

        return request
    }

    case getCharacters
}
