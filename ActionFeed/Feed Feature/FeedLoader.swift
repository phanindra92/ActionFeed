//
//  FeedLoader.swift
//  ActionFeed
//
//  Created by phanindra on 21/12/21.
//

import Foundation

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedImage], Error>
    func load(completion: @escaping (Result) -> Void)
}
