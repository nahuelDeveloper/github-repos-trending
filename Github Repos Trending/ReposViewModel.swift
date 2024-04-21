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
    @Published private(set) var state = ReposViewState.idle
    @Published private(set) var repos = [Repo]()
    var cancellables = [AnyCancellable]()
    
    init(reposService: ReposServicing) {
        self.reposService = reposService
    }
        
    func loadRepos() {
        state = .loading
        reposService.fetchRepos()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(_) = completion {
                    self.state = .failed
                }
            } receiveValue: { repos in
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.repos = repos
                    self.state = .loaded
                }
            }
            .store(in: &cancellables)
    }
}

enum ReposViewState {
    case idle
    case loading
    case loaded
    case failed
}
