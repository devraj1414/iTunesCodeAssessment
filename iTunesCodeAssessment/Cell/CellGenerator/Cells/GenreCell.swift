//
//  GenereCell.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 16/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import UIKit

struct GenreInfo{
    let genreName : String
}
class GenreCell: UITableViewCell, GenericCell {
 
   private let genreLabel : UILabel = {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.font = UIFont.boldSystemFont(ofSize: 20)
            lbl.textAlignment = .center
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(genreLabel)
            self.setUpConstraints()
      }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
             genreLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
             genreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
             genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
             genreLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
     }
     
    func configureCell(data genereInfo : Genre) {
            genreLabel.text = genereInfo.name
    }
}
