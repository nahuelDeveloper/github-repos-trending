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
        List {
            ForEach(reposViewModel.repos) { repo in
                Text(repo.name)
            }
        }
        .onAppear {
            reposViewModel.loadRepos()
        }
    }
}

#Preview {
    ReposView(reposViewModel: ReposViewModel(reposService: MockReposService()))
}
