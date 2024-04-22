//
//  StorageManager.swift
//  Github Repos Trending
//
//  Created by Nahuel Jose Roldan on 22/04/2024.
//

import Combine
import CoreData

class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RepoEntity")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func loadRepos() -> AnyPublisher<[Repo], Error> {
        let request: NSFetchRequest<RepoEntity> = NSFetchRequest<RepoEntity>(entityName: "RepoEntity")
        
        do {
            let repos = try persistentContainer.viewContext.fetch(request)
            return Just(repos.map { $0.toRepo() })
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func saveRepos(_ repos: [Repo]) {
        let context = persistentContainer.viewContext
        for repo in repos {
            _ = RepoEntity.create(from: repo, context: context)
        }
        saveContext()
    }
}
