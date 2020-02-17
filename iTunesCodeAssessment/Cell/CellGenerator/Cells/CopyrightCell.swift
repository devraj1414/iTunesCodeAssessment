//
//  CopyrightCell.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 16/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import UIKit
struct CopywrightInfo{
    let copywrightText : String
}
class CopyrightCell: UITableViewCell, GenericCell {
 
   private let copywrightLabel : UILabel = {
            let lbl = UILabel()
            lbl.textColor = .black
            lbl.font = UIFont.systemFont(ofSize: 12)
            lbl.textAlignment = .left
            lbl.lineBreakMode = NSLineBreakMode.byWordWrapping
            lbl.numberOfLines = 0
            lbl.translatesAutoresizingMaskIntoConstraints = false
            return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(copywrightLabel)
            self.setUpConstraints()
      }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints(){
             copywrightLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
             copywrightLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
             copywrightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
             copywrightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
     }
     
    func configureCell(data copywrightInfo : CopywrightInfo) {
             copywrightLabel.text = copywrightInfo.copywrightText
    }
}
