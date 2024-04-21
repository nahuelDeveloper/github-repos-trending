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
            content
                .navigationTitle("Trending")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    reposViewModel.loadRepos()
                }
        }
    }
    
    private var content: some View {
        switch reposViewModel.state {
        case .idle:
            Color.clear.eraseToAnyView()
        case .loading:
            Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .loaded:
            List {
                ForEach(reposViewModel.repos) { repo in
                    RepoRowView(repo: repo)
                }
            }.eraseToAnyView()
        case .failed:
            // TODO: Add Lottie retry view
            Text("Error fetching trending repos").eraseToAnyView()
        }
    }
}

#Preview {
    ReposView(reposViewModel: ReposViewModel(reposService: MockReposService()))
}
