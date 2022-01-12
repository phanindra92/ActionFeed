//
//  FeedCacheTestHelpers.swift
//  ActionFeedTests
//
//  Created by phanindra on 02/01/22.
//

import Foundation
import ActionFeed

extension Date {
    private var feedCacheMaxAgeInDays: Int { return 7 }
    
    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -feedCacheMaxAgeInDays)
    }
    
    private func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
}

extension Date {
    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
}
