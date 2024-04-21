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
    @Published private(set) var repos = [Repo]()
    var cancellables = [AnyCancellable]()
    
    init(reposService: ReposServicing) {
        self.reposService = reposService
    }
        
    func loadRepos() {
        reposService.fetchRepos().sink { completion in
            
        } receiveValue: { repos in
            self.repos = repos
        }
        .store(in: &cancellables)
    }
}
