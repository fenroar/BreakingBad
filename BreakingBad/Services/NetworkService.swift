//
//  NetworkService.swift
//  BreakingBad
//
//  Created by Peter Su on 19/01/2020.
//  Copyright © 2020 fenroar. All rights reserved.
//

import Foundation

protocol NetworkService {
    func getCharacters(_ onComplete: @escaping ((Result<[Character], Error>) -> Void))
}

struct NetworkManager: NetworkService {

    private let provider = NetworkProvider()
    private let decoder = JSONDecoder()

    func getCharacters(_ onComplete: @escaping ((Result<[Character], Error>) -> Void)) {
        provider.requestArray(.getCharacters) { result in
            self.decodeResult(result, type: [Character].self, onComplete: onComplete)
        }
    }

    private func decodeResult<T: Codable>(_ result: Result<Data, Error>, type: T.Type, onComplete: @escaping ((Result<T, Error>) -> Void)) {

        switch result {
        case .success(let data):
            do {
                let typedResult = try self.decoder.decode(type, from: data)

                DispatchQueue.main.async {
                    onComplete(.success(typedResult))
                }
            } catch {
                DispatchQueue.main.async {
                    onComplete(.failure(error))
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                onComplete(.failure(error))
            }
        }
    }
}

private class NetworkProvider {

    private let defaultSession = URLSession(configuration: .default)

    private var dataTask: URLSessionDataTask?

    func requestArray(_ endpoint: Endpoint, onComplete: @escaping ((Result<Data, Error>) -> ())) {
        // cancel existing data tasks if any
        dataTask?.cancel()

        do {
            let request = try endpoint.asUrlRequest()
            dataTask = defaultSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    onComplete(.failure(error))
                } else {
                    guard let data = data else {
                        return onComplete(.failure(NetworkError.incorrectResultType))
                    }

                    onComplete(.success(data))
                }
            }

            dataTask?.resume()
        } catch {
            onComplete(.failure(error))
        }
    }
}
