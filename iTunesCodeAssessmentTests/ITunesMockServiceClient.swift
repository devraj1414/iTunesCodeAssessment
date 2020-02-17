//
//  ITunesMockServiceClient.swift
//  iTunesCodeAssessmentTests
//
//  Created by Suruchi Kumari on 17/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation
class MockTask: URLSessionDataTask {
  private let data: Data?
  private let urlResponse: URLResponse?
  private let err: Error?

  var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
  init(data: Data?, urlResponse: URLResponse?, error: Error?) {
    
    self.data = data
    self.urlResponse = urlResponse
    self.err = error
  }
  override func resume() {
    DispatchQueue.main.async {
        self.completionHandler!(self.data, self.urlResponse, self.err)
    }
  }
}

class MockURLSession: URLSession {
    var cachedUrl : URL?
    private let mockTask: MockTask
      init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error:
        error)
    }
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
         self.cachedUrl = url
          mockTask.completionHandler = completionHandler
          return mockTask
    }
}
