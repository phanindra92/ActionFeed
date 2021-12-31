//
//  FeedStore.swift
//  ActionFeed
//
//  Created by phanindra on 31/12/21.
//

import Foundation

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    
    func deleteChechedFeed(completion: @escaping DeletionCompletion)
    func insert(_ items: [FeedItem], timestamp: Date, completion: @escaping InsertionCompletion)
}
