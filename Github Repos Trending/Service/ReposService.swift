//
//  ReposService.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import Foundation
import Combine

class ReposService: ReposServicing {
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRepos() -> AnyPublisher<[Repo], Error> {
        return fetchReposFromLocalStorage()
            .flatMap { localRepos -> AnyPublisher<[Repo], Error> in
                if localRepos.isEmpty {
                    return self.fetchReposFromAPI()
                        .handleEvents(receiveOutput: { fetchedRepos in
                            StorageManager.shared.saveRepos(fetchedRepos)
                        })
                        .eraseToAnyPublisher()
                } else {
                    return Just(localRepos)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
        
    private func fetchReposFromLocalStorage() -> AnyPublisher<[Repo], Error> {
        return StorageManager.shared.loadRepos()
    }
    
    private func fetchReposFromAPI() -> AnyPublisher<[Repo], Error> {
        let url = URL(string: "https://api.github.com/search/repositories?q=language=+sort:stars")!
        return NetworkManager.fetchURL(url)
    }
}
