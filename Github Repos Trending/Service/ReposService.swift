//
//  ReposService.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import Foundation
import Combine

class ReposService: ReposServicing {
    func fetchRepos() -> AnyPublisher<[Repo], Error> {
        let url = URL(string: "https://api.github.com/search/repositories?q=language=+sort:stars")!
        return NetworkManager.fetchURL(url)
    }
}
