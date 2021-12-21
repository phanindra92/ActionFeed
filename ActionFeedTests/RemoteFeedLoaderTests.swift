//
//  RemoteFeedLoaderTests.swift
//  ActionFeedTests
//
//  Created by phanindra on 21/12/21.
//

import XCTest
import ActionFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertEqual(client.requestedURLs, [])
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "Test", code: 0, userInfo: nil)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedErrors, [.connectivityError])
    }
    
    
    //MARK: Helpers
    func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (RemoteFeedLoader, HTTPClientSpy) {
        let client = HTTPClientSpy()
        return (RemoteFeedLoader(url: url, client: client), client)
    }

}


class HTTPClientSpy: HTTPClient {
    var requestedURLs = [URL]()
    var completions = [(Error) -> Void]()
    
    func get(from url: URL, completion: @escaping (Error) -> Void) {
        completions.append(completion)
        requestedURLs.append(url)
    }
    
    func complete(with error: Error, at index: Int = 0) {
        completions[index](error)
    }
    
}
