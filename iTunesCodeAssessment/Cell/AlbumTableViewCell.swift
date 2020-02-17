//
//  AlbumTableViewCell.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 27/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//
/*
 On launch, the user should see a UITableView showing one album per cell. Each cell should display the name of the album, the artist, and the album art (thumbnail image). Tapping on a cell should push another view controller onto the navigation stack where we see a larger image at the top of the screen and the same information that was shown on the cell, plus genre, release date, and copyright info below the image. A button should also be included on this second view that when tapped fast app switches to the album page in the iTunes store. The button should be centered horizontally and pinned 20 points from the bottom of the view and 20 points from the leading and trailing edges of the view. Unlike the first one, this “detail” view controller should NOT use a UITableView for layout.
 */
import UIKit

class AlbumTableViewCell : UITableViewCell {
    
    private let albumThumbNailImageView : UIImageView = {
        let albumThumbNailImage = UIImageView()
        albumThumbNailImage.translatesAutoresizingMaskIntoConstraints = false
        albumThumbNailImage.image = UIImage(named: "imag.png")
        return albumThumbNailImage
    }()
    
    private let albuNameLabel : UILabel = {
         let lbl = UILabel()
         lbl.textColor = .black
         lbl.font = UIFont.boldSystemFont(ofSize: 20)
         lbl.textAlignment = .left
         lbl.translatesAutoresizingMaskIntoConstraints = false
         return lbl
     }()
     
     private let artistLabel : UILabel = {
         let lbl = UILabel()
         lbl.textColor = .black
         lbl.font = UIFont.systemFont(ofSize: 18)
         lbl.textAlignment = .left
         lbl.numberOfLines = 0
         lbl.translatesAutoresizingMaskIntoConstraints = false
         return lbl
     }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(albumThumbNailImageView)
        addSubview(albuNameLabel)
        addSubview(artistLabel)
        self.setUpConstraints()
    }
    
    
    func setUpConstraints(){
    
        albumThumbNailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        albumThumbNailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        albumThumbNailImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        albumThumbNailImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true

        albuNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        albuNameLabel.leadingAnchor.constraint(equalTo: albumThumbNailImageView.trailingAnchor, constant: 5).isActive = true
        albuNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        albuNameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        artistLabel.topAnchor.constraint(equalTo: albuNameLabel.bottomAnchor, constant: 0).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo: albumThumbNailImageView.trailingAnchor, constant: 5).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10).isActive = true
        artistLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var viewModel : AlbumCellViewModel?{
        didSet{
            self.bindViewModel()
        }
    }

    private func bindViewModel(){
        if let aName = viewModel?.albumName, let aArtistName = viewModel?.artistName, let thumbUrl = viewModel?.thumbnailUrl {
            self.albuNameLabel.text = aName
            self.artistLabel.text = aArtistName
            self.albumThumbNailImageView.loadImageUsingCache(thumbUrl)
        }
    }

}
