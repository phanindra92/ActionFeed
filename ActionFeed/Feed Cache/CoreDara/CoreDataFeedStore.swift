//
//  CoreDataFeedStore.swift
//  ActionFeed
//
//  Created by phanindra on 03/01/22.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
    
    public static let modelName = "FeedStore"
    public static let model = NSManagedObjectModel(name: modelName, in: Bundle(for: CoreDataFeedStore.self))

    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    public struct ModelNotFound: Error {
        public let modelName: String
    }

    public init(storeURL: URL) throws {
        guard let model = CoreDataFeedStore.model else {
            throw ModelNotFound(modelName: CoreDataFeedStore.modelName)
        }

        container = try NSPersistentContainer.load(
            name: CoreDataFeedStore.modelName,
            model: model,
            url: storeURL
        )
        context = container.newBackgroundContext()
    }

    deinit {
        cleanUpReferencesToPersistentStores()
    }

    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }

    public func retrieve(completion: @escaping RetrievalCompletion) {
        let context = context
        context.perform {
            completion(Result {
                if let managedCache = try ManagedCache.find(in: context), let feed = managedCache.feed.array as? [ManagedFeedImage] {
                    return CachedFeed(feed: feed.toLocal(), timestamp: managedCache.timestamp)
                } else {
                    return .none
                }
            })
        }
    }

    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        let context = context
        context.perform {
            do {
                let managedCache = try ManagedCache.makeUnique(in: context)
                managedCache.timestamp = timestamp
                managedCache.feed = NSOrderedSet(array: feed.toManagedFeedImages(in: context))
                try context.save()
                completion(.success(()))
            } catch {
                context.rollback()
                completion(.failure(error))
            }
        }
    }

    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        let context = context
        context.perform {
            do {
                try ManagedCache.delete(in: context)
                completion(.success(()))
            } catch {
                context.rollback()
                completion(.failure(error))
            }
        }
    }
}

private extension Array where Element == LocalFeedImage {
    func toManagedFeedImages(in context: NSManagedObjectContext) -> [ManagedFeedImage] {
        return map {
            let managedFeedImage = ManagedFeedImage(context: context)
            managedFeedImage.id = $0.id
            managedFeedImage.imageDescription = $0.description
            managedFeedImage.location = $0.location
            managedFeedImage.url = $0.url
            return managedFeedImage
        }
    }
}

private extension Array where Element == ManagedFeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map {
            LocalFeedImage(id: $0.id, description: $0.imageDescription, location: $0.location, url: $0.url)
        }
    }
}