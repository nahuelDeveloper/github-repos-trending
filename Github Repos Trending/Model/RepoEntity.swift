//
//  RepoEntity.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 22/04/2024.
//

import Foundation
import CoreData

class RepoEntity: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var fullName: String
    @NSManaged var ownerAvatarURL: String
    @NSManaged var repoDescription: String
    @NSManaged var language: String?
    @NSManaged var stargazersCount: Int
    
    static func create(from repo: Repo, context: NSManagedObjectContext) -> RepoEntity {
        let entity = RepoEntity(context: context)
        entity.id = repo.id
        entity.name = repo.name
        entity.fullName = repo.full_name
        entity.ownerAvatarURL = repo.owner.avatar_url
        entity.repoDescription = repo.description
        entity.language = repo.language
        entity.stargazersCount = repo.stargazers_count
        return entity
    }
}

extension RepoEntity {
    
    func toRepo() -> Repo {
        return Repo(id: self.id, name: self.name, full_name: self.fullName,
                    owner: Owner(avatar_url: self.ownerAvatarURL), description: self.repoDescription,
                    language: self.language, stargazers_count: self.stargazersCount)
    }    
}
