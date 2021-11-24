//
//  ViewModel.swift
//  qwert
//
//  Created by Anastasiya on 22.11.21.
//

import UIKit

protocol ViewModelAlbumsCellProtocol {
    var album: String { get }
}

class ViewModelAlbumsCell: ViewModelAlbumsCellProtocol {
    
    init(album: Album) {
        self.albums = album
    }

    var album: String {
        albums.title ?? ""
    }

    // MARK: Private

    private var albums: Album

}
