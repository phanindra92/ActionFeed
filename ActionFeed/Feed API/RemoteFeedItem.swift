//
//  RemoteFeedItem.swift
//  ActionFeed
//
//  Created by phanindra on 31/12/21.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
