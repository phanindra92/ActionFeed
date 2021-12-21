//
//  FeedItem.swift
//  ActionFeed
//
//  Created by phanindra on 21/12/21.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
