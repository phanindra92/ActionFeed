//
//  SharedTestHelpers.swift
//  ActionFeedTests
//
//  Created by phanindra on 02/01/22.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "https://any-url.com")!
}
