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
    let description: String
    let language: String?
    let stargazers_count: Int
    
    var avatarURL: URL {
        owner.imageURL
    }
}
