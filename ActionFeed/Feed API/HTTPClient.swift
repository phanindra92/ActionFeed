//
//  HTTPClient.swift
//  ActionFeed
//
//  Created by phanindra on 22/12/21.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    /// Completion handler can be invoked in any thread.
    /// Clients also responsible to dispatch to appropriate threads, if needed.
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
