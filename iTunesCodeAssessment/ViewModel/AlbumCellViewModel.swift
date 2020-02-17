//
//  AlbumCellViewModel.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 27/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

protocol AlbumCellViewModel{
    var albumName : String{get}
    var albumKind : String{get}
    var artistName : String{get}
    var thumbnailUrl : URL?{get}
    var releaseDate : String{get}
    var genres : [Genre]{get}
    var copywrightInfo : String{get}
    var albumUrl : URL?{get}
}

extension Album: AlbumCellViewModel {
    var thumbnailUrl: URL? {
         return URL(string: artworkUrl100)!
    }
    
    var albumUrl: URL? {
         return URL(string: url)!
    }
    
    var copywrightInfo: String {
        return copyright
    }
    
    var albumName: String {
        return name
    }
    var albumKind: String {
        return kind
    }
    
}
