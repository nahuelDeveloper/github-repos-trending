//
//  MockReposService.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import Foundation
import Combine

class MockReposService: ReposServicing {
    
    func fetchRepos() -> AnyPublisher<[Repo], Error> {
        let repos = Bundle.main.decode([Repo].self, from: "mock-items.json")
        return Just(repos)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
