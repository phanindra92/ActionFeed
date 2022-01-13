//
//  FeedLoader.swift
//  ActionFeed
//
//  Created by phanindra on 21/12/21.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
