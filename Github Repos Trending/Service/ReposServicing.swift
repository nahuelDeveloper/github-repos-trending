//
//  ReposServicing.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import Combine

protocol ReposServicing {
    func fetchRepos() -> AnyPublisher<[Repo], Error>
}
