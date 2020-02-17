//
//  DetailTableCellViewModel.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 16/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import UIKit

typealias CopyrightInfoCellGenerator  = TableCellGenerator<CopyrightCell, CopywrightInfo>
typealias AlbumInfoCellGenerator  = TableCellGenerator<AlbumInfoCell, AlbumInfo>
typealias GenreInfoCellGenerator = TableCellGenerator<GenreCell, Genre>
class DetailTableCellViewModel{
    var cellItems : [CellGenerator] = []
       func createAlbumInfoCell(albumInfo : AlbumInfo){
           cellItems.append(AlbumInfoCellGenerator.init(item: albumInfo))
       }
    
    func createGenreCell(genreInfoArray : [Genre]){
        for genre in genreInfoArray{
            cellItems.append(GenreInfoCellGenerator.init(item: genre))
        }
    }
    
    func createCopyrightCell(copywrightText : CopywrightInfo){
              cellItems.append(CopyrightInfoCellGenerator.init(item: copywrightText))
          }
}
