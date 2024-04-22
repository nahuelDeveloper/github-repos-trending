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
        Text("This is the description of the repo. Here we will show a text with the description of the repo.")
    }
}

#Preview {
    RepoRowView(repo: Repo(id: 123, name: "awesome-ios", full_name: "vzousa/awesome-ios",
                           owner: Owner(avatar_url: "https://avatars.githubusercontent.com/u/4314092?v=4")), 
                isExpanded: false)
}
