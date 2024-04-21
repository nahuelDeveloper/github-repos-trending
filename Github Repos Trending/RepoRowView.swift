//
//  RepoRowView.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import SwiftUI

struct RepoRowView: View {
    let repo: Repo
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: repo.avatarURL) { image in
                image.resizable()
            } placeholder: {
                Spinner(isAnimating: true, style: .medium)
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            VStack(alignment: .leading, spacing: 20) {
                Text(repo.name)
                    .font(.headline)
                Text(repo.full_name)
                    .font(.title2)
            }
        }
    }
}

#Preview {
    RepoRowView(repo: Repo(id: 123, name: "awesome-ios", full_name: "vzousa/awesome-ios",
                           owner: Owner(avatar_url: "https://avatars.githubusercontent.com/u/4314092?v=4")))
}
