//
//  RemoteFeedLoader.swift
//  ActionFeed
//
//  Created by phanindra on 21/12/21.
//

import Foundation

public final class RemoteFeedLoader {
    let url: URL
    let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public enum Result: Equatable {
        case success([FeedItem])
        case failure(Error)
    }
    
    public init (url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url, completion: { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(FeedItemsMaaper.map(data, from: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        })
    }    
}
