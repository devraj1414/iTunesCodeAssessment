//
//  ItunesServiceClient.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 26/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

enum FetchFailureReason : Int , Error{
    case unauthorisedError = 401
    case dataNotFound = 404
    case serviceUnavilable = 503
    case timeOut = 504
    
}
class ITunesServiceClient {
    typealias FetchAlbumsResult = FetchResult<[Album], FetchFailureReason>
    typealias FetchAlbumsCompletion = (_ fetchResult : FetchAlbumsResult)->Void
    var session : URLSession = URLSession.shared
    let url = URL(string:"https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json")
    func getAlbums(completion : @escaping FetchAlbumsCompletion){
        guard let url = url else{
            return
        }
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil || data == nil {
                guard let response = response else {
                    completion(.failure(FetchFailureReason.dataNotFound))
                    return
                }
                completion(.failure(FetchFailureReason(rawValue: (response.getStatusCode())!)))
                   return
                   
               }
               guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(FetchFailureReason.dataNotFound))
                   return
               }

               guard let mime = response.mimeType, mime == "application/json" else {
                   print("Wrong MIME type!")
                   return
               }

               do {
                let album = try JSONDecoder().decode(AlbumFeed.self, from: data!)
                completion(.success(data: album.feed.results))
               } catch {
                   print("JSON error: \(error.localizedDescription)")
               }
        }
        task.resume()
    }
}

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
