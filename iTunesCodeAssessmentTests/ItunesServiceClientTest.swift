//
//  ItunesServiceClientTest.swift
//  iTunesCodeAssessmentTests
//
//  Created by Suruchi Kumari on 06/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import XCTest
@testable import iTunesCodeAssessment
class ItunesServiceClientTest: XCTestCase {
    var itunesClient : ITunesServiceClient!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        itunesClient = ITunesServiceClient()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        itunesClient = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testForValidAlbumsResponseData(){
        XCTAssertEqual(itunesClient.url!.host, "rss.itunes.apple.com")
        XCTAssertEqual(itunesClient.url!.path, "/api/v1/us/apple-music/coming-soon/all/100/explicit.json")
        itunesClient.getAlbums { result in
            switch result{
            case .success(let albums):
                XCTAssert(albums.count > 0)
            case .failure(_):
                 XCTFail("Result contains Failure, but Success was expected.")
            }
        }
    }
    
    func testFetchAlbumsWithExpectedURLHostAndPath(){
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json") else{
                   return
               }
        
        let albumsResult = expectation(description: "Result as Albums")
               let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
                   XCTAssertNil(error)
                do {
                    let albumFeed = try JSONDecoder().decode(AlbumFeed.self, from: data!)
                        let album = albumFeed.feed.results[0]
                        XCTAssertEqual(album.kind, "album")
                        XCTAssert((album.albumName as Any) is String)
                        XCTAssert((album.artistName as Any) is String)
                        XCTAssert((album.genres as Any) is [Genre])
                        albumsResult.fulfill()
                    
                    } catch {
                    }
               }
               dataTask.resume()
               waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testForAlbumsResponseError(){
        let itunesClient = ITunesServiceClient()
        let erroor = NSError(domain: "error", code: 404, userInfo: nil)
        let mockURLSession  = MockURLSession(data: nil, urlResponse: nil, error: erroor)
        itunesClient.session = mockURLSession
        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?
        itunesClient.getAlbums { (result) in
            switch result{
            case .failure(let error):
                errorResponse = error
                errorExpectation.fulfill()
            default :
                print("Failer")
            }
        }
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }

}
