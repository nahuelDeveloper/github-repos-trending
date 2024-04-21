//
//  Repo.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import Foundation

struct Repo: Decodable, Identifiable {
    let id: Int
    let name: String
    let full_name: String
    let owner: Owner
    
    var avatarURL: URL {
        owner.imageURL
    }
    
    static func mockRepo() -> Repo {
        Repo(id: 123, name: "awesome-ios", 
             full_name: "vzousa/awesome-ios",
             owner: Owner(avatar_url: "https://avatars.githubusercontent.com/u/4314092?v=4"))
    }
}
