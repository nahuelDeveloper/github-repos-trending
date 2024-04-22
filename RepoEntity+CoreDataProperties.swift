//
//  RepoEntity+CoreDataProperties.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 22/04/2024.
//
//

import Foundation
import CoreData


extension RepoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepoEntity> {
        return NSFetchRequest<RepoEntity>(entityName: "RepoEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var fullName: String?
    @NSManaged public var ownerAvatarURL: String?
    @NSManaged public var repoDescription: String?
    @NSManaged public var language: String?
    @NSManaged public var stargazersCount: Int16

}

extension RepoEntity : Identifiable {

}
