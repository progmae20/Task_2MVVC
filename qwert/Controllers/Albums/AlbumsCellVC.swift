//
//  AlbumsCellVC.swift
//  qwert
//
//  Created by Anastasiya on 16.11.21.
//

import UIKit

class AlbumsCellVC: UITableViewCell {

    @IBOutlet weak var nameAlbum: UILabel!
    
    var viewModel: ViewModelAlbumsCellProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            nameAlbum.text = viewModel.album
        }
    }
}
