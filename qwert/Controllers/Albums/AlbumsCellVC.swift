//
//  AlbumsCellVC.swift
//  qwert
//
//  Created by Anastasiya on 16.11.21.
//

import UIKit

class AlbumsCellVC: UITableViewCell {

    @IBOutlet weak var nameAlbum: UILabel!
    
    func configure(albums: Album) {
        nameAlbum.text = albums.title
    }
}
