//
//  AlbumViewModel.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 26/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation

class AlbumViewModel{

    enum AlbumCellType{
        case normal(cellViewModel : AlbumCellViewModel)
    }
    let iTunesServiceClient : ITunesServiceClient
    init(iTunesServiceClient : ITunesServiceClient = ITunesServiceClient()) {
        self.iTunesServiceClient = iTunesServiceClient
    }
    
    let albumCells = Bindable([AlbumCellType]())

    func fetchiTunesAlbum(){
        self.iTunesServiceClient.getAlbums { (result) in
            print(result)
            switch result{
            case .success(let albums):
                guard albums.count > 0 else{
                    return
                }
                self.albumCells.value = albums.compactMap{ .normal(cellViewModel : $0 as AlbumCellViewModel)}
            case .failure(let error):
                print("Error")
            }
        }
    }
    
    
}
