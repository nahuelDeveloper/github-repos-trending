//
//  RepoRowView.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import SwiftUI

struct RepoRowView: View {
    var repo: Repo?
    let isExpanded: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                AsyncImage(url: repo?.avatarURL) { image in
                    image.resizable()
                } placeholder: {
                    Spinner(isAnimating: true, style: .medium)
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text(repo?.name)
                    .font(.headline)
                Text(repo?.full_name)
                    .font(.title2)
                if isExpanded {
                    expandedView
                }
            }
        }
    }
    
    private var expandedView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(repo?.description)
            HStack(spacing: 60) {
                HStack {
                    Image(systemName: "dot.square.fill")
                        .foregroundStyle(.blue)
                    Text(repo?.language)
                }
                HStack {
                    if let starsCount = repo?.stargazers_count {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(starsCount)")
                    }
                }
            }
            .font(.caption)
        }
    }
}

#Preview {
    RepoRowView(repo: Repo(id: 123, name: "awesome-ios", full_name: "vzousa/awesome-ios",
                           owner: Owner(avatar_url: "https://avatars.githubusercontent.com/u/4314092?v=4"),
                          description: "A repo for iOS", language: "Swift", stargazers_count: 5630),
                isExpanded: true)
}
