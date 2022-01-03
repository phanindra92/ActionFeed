//
//  FeedStore.swift
//  ActionFeed
//
//  Created by phanindra on 31/12/21.
//

import Foundation

public enum RetriveCachedFeedResult {
    case empty
    case found(feed: [LocalFeedImage], timestamp: Date)
    case failure(Error)
}

public protocol FeedStore {
    typealias DeletionCompletion = (Error?) -> Void
    typealias InsertionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetriveCachedFeedResult) -> Void
    
    /// Completion handler can be invoked in any thread.
    /// Clients also responsible to dispatch to appropriate threads, if needed.
    func deleteChechedFeed(completion: @escaping DeletionCompletion)
    
    /// Completion handler can be invoked in any thread.
    /// Clients also responsible to dispatch to appropriate threads, if needed.
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)
    
    /// Completion handler can be invoked in any thread.
    /// Clients also responsible to dispatch to appropriate threads, if needed.
    func retrieve(completion: @escaping RetrievalCompletion)
}
