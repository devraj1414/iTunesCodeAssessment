//
//  TableCells.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 16/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation
import UIKit

struct AlbumInfo{
    let albumName : String
    let artistName : String
    let releaseDAte : String
}
class AlbumInfoCell: UITableViewCell, GenericCell {
 
   private let albuNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let artistLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          addSubview(albuNameLabel)
          addSubview(artistLabel)
          self.setUpConstraints()
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
     
         albuNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
         albuNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
         albuNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
         albuNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
         
         artistLabel.topAnchor.constraint(equalTo: albuNameLabel.bottomAnchor, constant: 4).isActive = true
         artistLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
         artistLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
         artistLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
         
     }
     
    func configureCell(data albumInfo : AlbumInfo) {
        albuNameLabel.text = albumInfo.albumName
        artistLabel.text = albumInfo.artistName + "   release on " + albumInfo.releaseDAte
    }
}
