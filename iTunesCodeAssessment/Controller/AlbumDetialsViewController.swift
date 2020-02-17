//
//  AlbumDetialsViewController.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 05/02/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//


import UIKit

enum AlbumDetailsEnum : Int, CaseIterable{
    case AlbumInfo
    case Genere
    case CopyWright
}

class AlbumDetialsViewController: UIViewController {

    var album : AlbumCellViewModel? {
        didSet{
            self.configureDetailsView()
        }
    }
    
    internal let viewModel = DetailTableCellViewModel()
    private let albumImageView : UIImageView = {
           let albumImageView = UIImageView()
           albumImageView.translatesAutoresizingMaskIntoConstraints = false
           albumImageView.image = UIImage(named: "imag.png")
           return albumImageView
       }()
       
       private let albumNameLabel : UILabel = {
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
    
    private let itunesStoreButton : UIButton = {
               let button = UIButton()
               button.translatesAutoresizingMaskIntoConstraints = false
               button.backgroundColor = UIColor.lightGray
               button.setTitle("iTunes Link", for: .normal)
               button.addTarget(self, action: #selector(openiTunesLink), for: .touchUpInside)
               return button
           }()
    
    
    private let detailsTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    @objc func openiTunesLink(){
        if let url = album?.albumUrl{
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.view.addSubview(albumImageView)
        self.view.addSubview(albumNameLabel)
        self.view.addSubview(artistLabel)
        self.view.addSubview(detailsTableView)
         self.view.addSubview(itunesStoreButton)
        self.detailsTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cc")
        self.detailsTableView.register(AlbumInfoCell.self, forCellReuseIdentifier: "AlbumInfoCell")
        self.detailsTableView.register(GenreCell.self, forCellReuseIdentifier: "GenreCell")
        self.detailsTableView.register(CopyrightCell.self, forCellReuseIdentifier: "CopyrightCell")
        self.setUpConstraints()
        self.createDetailsTableCellData()
       
    }
    
    
    func createDetailsTableCellData(){
        for albumDeatilCase in AlbumDetailsEnum.allCases{
            switch albumDeatilCase {
            case .AlbumInfo:
                let albumInfo = AlbumInfo(albumName: album!.albumName, artistName: album!.artistName, releaseDAte: album!.releaseDate)
                self.viewModel.createAlbumInfoCell(albumInfo: albumInfo)
            case .Genere:
                let genereArray = album?.genres
                self.viewModel.createGenreCell(genreInfoArray: genereArray!)
            case .CopyWright:
                self.viewModel.createCopyrightCell(copywrightText: CopywrightInfo(copywrightText: album!.copywrightInfo))
            }
        }
    }
    
    func setUpConstraints(){
        albumImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100).isActive = true
        albumImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor).isActive = true
        
        detailsTableView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 10).isActive = true
        detailsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        detailsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 5).isActive = true
        detailsTableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        itunesStoreButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        itunesStoreButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        itunesStoreButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    
    func configureDetailsView(){
        self.title = album?.albumName
        self.albumImageView.loadImageUsingCache(album!.thumbnailUrl!)
        
        self.detailsTableView.delegate = self
        self.detailsTableView.dataSource = self
//        self.albumNameLabel.text = album?.albumName
//        self.artistLabel.text = album?.artistName
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AlbumDetialsViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.cellItems[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseIdentifier) else {
                return UITableViewCell()
        }
        item.confgure(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == viewModel.cellItems.count-1{
            return UITableView.automaticDimension
        }else{
            return 40
        }
    }
        
}
