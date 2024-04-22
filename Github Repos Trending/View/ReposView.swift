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
    @State var expandedRepo: Repo?
    
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
                RepoRowView(repo: repo, isExpanded: isRepoExpanded(repo))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("TAPPED REPO: \(repo?.name)")
                        expandedRepo = repo
                    }
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
            retryView.eraseToAnyView()
        }
    }
    
    private func isRepoExpanded(_ repo: Repo?) -> Bool {
        guard let repo = repo, let expandedRepo = expandedRepo else { return false }
        
        return repo.id == expandedRepo.id
    }
    
    private var retryView: some View {
        VStack {
            ZStack {
                Color.darkOpacity
                VStack(spacing: 40) {
                    LottieView()
                        .frame(maxWidth: 200, maxHeight: 300)
                    
                    VStack(spacing: 15) {
                        Text("Something went wrong...")
                            .foregroundStyle(.white)
                            .bold()
                        Text("An alien is blocking your signal")
                            .foregroundStyle(.white)
                    }
                    
                    VStack(spacing: 20) {
                        Button {
                            reposViewModel.loadRepos()
                        } label: {
                            Text("RETRY")
                                .padding(.horizontal, 120)
                                .padding(.vertical, 16)
                                .foregroundColor(.white)
                                .background(Color.darkGreen)
                                .cornerRadius(8)
                        }
                        Button {
                            // This state shouldn't be possible. If no repos were loaded, and the user doesn't retry to fetch them from the API, the app has nothing to display in the UI. But i will keep it to respect the design.
                            reposViewModel.state = .idle
                        } label: {
                            Text("Cancel")
                                .padding(.horizontal, 120)
                                .padding(.vertical, 16)
                                .foregroundColor(Color.darkGreen)
                                .background(.white)
                                .border(Color.darkGreen, width: 3)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ReposView(reposViewModel: ReposViewModel(reposService: MockReposService()))
}
