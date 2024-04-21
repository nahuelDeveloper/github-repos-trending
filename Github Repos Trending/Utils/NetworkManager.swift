//
//  NetworkManager.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import Foundation
import Combine

enum APIEnvironment {
    case mock
    case prod
}

class NetworkManager {
    
    static let apiEnvironment = APIEnvironment.prod
    
    static func fetchURL<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return result.data
            }
            .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
            .map { $0.items }
            .eraseToAnyPublisher()
    }
}

private struct APIResponse<T: Decodable>: Decodable {
    let items: T
}
