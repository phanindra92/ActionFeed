//
//  FeedCachePolicy.swift
//  ActionFeed
//
//  Created by phanindra on 02/01/22.
//

import Foundation

internal final class FeedCachePolicy {
    private init() {}
    
    private static let calendar = Calendar(identifier: .gregorian)
    
    private static var maxCacheAgnDays: Int { return 7 }
    
    internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgnDays, to: timestamp) else { return false }
        return date < maxCacheAge
    }
}
