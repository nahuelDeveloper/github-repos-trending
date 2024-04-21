//
//  Owner.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 21/04/2024.
//

import Foundation

struct Owner: Decodable {
    let avatar_url: String
    
    var imageURL: URL {
        URL(string: avatar_url)!
    }
}
