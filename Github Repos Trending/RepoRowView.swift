//
//  RepoRowView.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import SwiftUI
import EasySkeleton

struct RepoRowView: View {
    let repo: Repo
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: repo.avatarURL) { image in
                image.resizable()
            } placeholder: {
                Spinner(isAnimating: true, style: .medium)
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .skeletonable()
            VStack(alignment: .leading, spacing: 20) {
                Text(repo.name)
                    .font(.headline)
                    .skeletonable()
                Text(repo.full_name)
                    .font(.title2)
                    .skeletonable()
            }
        }.setSkeleton($isLoading)
    }
}

#Preview {
    RepoRowView(repo: Repo.mockRepo(), isLoading: .constant(false))
}
