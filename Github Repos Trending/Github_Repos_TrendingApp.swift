//
//  Github_Repos_TrendingApp.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import SwiftUI

@main
struct Github_Repos_TrendingApp: App {
    var body: some Scene {
        WindowGroup {
            createReposView()
        }
    }
    
    private func createReposView() -> some View {
        let viewModel = ReposViewModel()
        return ReposView(reposViewModel: viewModel)
    }
}
