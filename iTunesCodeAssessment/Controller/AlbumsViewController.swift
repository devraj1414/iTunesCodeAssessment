//
//  AlbumsViewController.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 24/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import UIKit

class AlbumsViewController: UITableViewController {

    let cellId = "cellId"
    let albumViewModel : AlbumViewModel = AlbumViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureAlumsView()
        self.bindViewModel()
        self.albumViewModel.fetchiTunesAlbum()
    }
    
    func bindViewModel(){
        albumViewModel.albumCells.bindAndFire() { [weak self] _ in                DispatchQueue.main.async {
            self?.tableView?.reloadData()
            }
        }
    }
    
    func configureAlumsView(){
        self.title = "Albums View"
        self.tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return albumViewModel.albumCells.value.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch albumViewModel.albumCells.value[indexPath.row] {
        case .normal(let cellViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? AlbumTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = cellViewModel
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let albumDetailsViewController: AlbumDetialsViewController = AlbumDetialsViewController()
        switch albumViewModel.albumCells.value[indexPath.row] {
               case .normal(let cellViewModel):
                albumDetailsViewController.album = cellViewModel
                self.navigationController?.pushViewController(albumDetailsViewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
