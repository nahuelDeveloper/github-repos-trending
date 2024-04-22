//
//  ReposView.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import SwiftUI
import SkeletonUI

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
            SkeletonList(with: reposViewModel.repos, quantity: 5) { loading, repo in
                RepoRowView(repo: repo)
                    .skeleton(with: loading,
                              animation: .pulse(),
                              appearance: .solid(color: Color.grayDark,
                                                 background: Color.grayLight),
                              shape: .capsule,
                              lines: 2,
                              scales: [1: 0.5])
            }
            .eraseToAnyView()
        case .failed:
            // TODO: Add Lottie retry view
            Text("Error fetching trending repos").eraseToAnyView()
        }
    }
}

#Preview {
    ReposView(reposViewModel: ReposViewModel(reposService: MockReposService()))
}
