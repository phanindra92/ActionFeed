//
//  CacheFeedUseCaseTests.swift
//  ActionFeedTests
//
//  Created by phanindra on 31/12/21.
//

import XCTest

class LocalFeedLoader {
    private let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
}

class FeedStore {
    var deleteCachedFeedCallCount: Int = 0
}

class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doesNotDeleteCacheUponCreation() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }

}
