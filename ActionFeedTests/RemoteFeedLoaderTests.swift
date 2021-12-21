//
//  RemoteFeedLoaderTests.swift
//  ActionFeedTests
//
//  Created by phanindra on 21/12/21.
//

import XCTest

class RemoteFeedLoaderTests: XCTestCase {

    class RemoteFeedLoader {
        let client: HTTPClient
        
        init(client: HTTPClient) {
            self.client = client
        }
    }
    
    class HTTPClient {
        var requestedURL: URL?
    }
    

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteFeedLoader(client: client)
        
        
        XCTAssertNil(client.requestedURL)
    }

}
