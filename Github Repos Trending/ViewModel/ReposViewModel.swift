//
//  ReposViewModel.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import SwiftUI
import Combine

class ReposViewModel: ObservableObject {
    let reposService: ReposServicing
    @Published var state = ReposViewState.idle
    @Published private(set) var repos = [Repo]()
    var cancellables = [AnyCancellable]()
    
    init(reposService: ReposServicing) {
        self.reposService = reposService
    }
    
    // Load repos using Combine
    func loadRepos() {
        state = .loading
        reposService.fetchRepos()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(_) = completion {
                    self.state = .failed
                }
            } receiveValue: { repos in
                self.repos = repos
            }
            .store(in: &cancellables)
    }
    
    // Load repos using Swift Concurrency
    @MainActor
    func loadRepos2() async {
        state = .loading
        repos = await fetchRepos()
    }
    
    private func fetchRepos() async -> [Repo] {
        let url = URL(string: "https://api.github.com/search/repositories?q=language=+sort:stars")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let result = try JSONDecoder().decode(APIResponse<[Repo]>.self, from: data)
            return result.items
        } catch {
            return []
        }
    }
}

enum ReposViewState {
    case idle
    case loading
    case failed
}
