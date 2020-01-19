//
//  NetworkError.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case incorrectResultType

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "")
        case .incorrectResultType:
            return NSLocalizedString("Unexpected response, could not deserialize to intended type", comment: "")
        }
    }
}
