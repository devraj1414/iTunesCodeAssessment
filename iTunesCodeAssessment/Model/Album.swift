//
//  Album.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 26/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

struct AlbumFeed : Codable{
    var feed : Feed
}
struct Feed : Codable{
    var title : String
    var results : [Album]
}
struct Album : Codable {
        var name : String
        var kind : String
        var artistName : String
        var releaseDate :String
        var artistUrl : String
        var artworkUrl100 : String
        var genres : [Genre]
        var copyright : String
        var url : String
       
}

struct Genre : Codable {
    var name : String
    var url : String
}
