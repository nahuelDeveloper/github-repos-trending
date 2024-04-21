//
//  ReposView.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import SwiftUI

struct ReposView: View {
    @ObservedObject var reposViewModel: ReposViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(reposViewModel.repos) { repo in
                    RepoRowView(repo: repo)
                }
            }
            .onAppear {
                reposViewModel.loadRepos()
            }
            .navigationTitle("Trending")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ReposView(reposViewModel: ReposViewModel(reposService: MockReposService()))
}
