//
//  ManagedCache+Helpers.swift
//  ActionFeed
//
//  Created by phanindra on 12/01/22.
//

import CoreData

extension ManagedCache {
    static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
        return try context.fetch(ManagedCache.fetchRequest()).first
    }

    static func delete(in context: NSManagedObjectContext) throws {
        try find(in: context).map(context.delete).map(context.save)
    }

    static func makeUnique(in context: NSManagedObjectContext) throws -> ManagedCache {
        try find(in: context).map(context.delete)
        return ManagedCache(context: context)
    }
}
