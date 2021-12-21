//
//  FeedLoader.swift
//  ActionFeed
//
//  Created by phanindra on 21/12/21.
//

import Foundation

enum FeedLoaderResult {
    case success([FeedItem])
    case failure(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (FeedLoaderResult) -> Void)
}
