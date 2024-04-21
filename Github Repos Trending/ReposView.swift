//
//  ReposView.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import SwiftUI
import EasySkeleton

struct ReposView: View {
    @ObservedObject var reposViewModel: ReposViewModel
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            createContentView()
                .navigationTitle("Trending")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    reposViewModel.loadRepos()
                }
        }
    }
    
    private func createContentView() -> some View {
        switch reposViewModel.state {
        case .idle, .loading:
            setLoading(true)
            return reposListView.eraseToAnyView()
        case .loaded:
            setLoading(false)
            return reposListView.eraseToAnyView()
        case .failed:
            // TODO: Add Lottie retry view
            isLoading = false
            return Text("Error fetching trending repos").eraseToAnyView()
        }
    }
    
    private var reposListView: some View {
        return List {
            ForEach(reposViewModel.repos) { repo in
                RepoRowView(repo: repo, isLoading: $isLoading)
            }.skeletonForEach(itemsCount: 5) { _ in
                RepoRowView(repo: Repo.mockRepo(), isLoading: $isLoading)
                    .skeletonable()
            }
            .setSkeleton($isLoading)
        }
        .eraseToAnyView()
    }
    
    private func setLoading(_ isLoading: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isLoading = isLoading
        }
    }
}

#Preview {
    ReposView(reposViewModel: ReposViewModel(reposService: MockReposService()))
}
