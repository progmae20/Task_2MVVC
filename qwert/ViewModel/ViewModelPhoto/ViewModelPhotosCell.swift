//
//  ViewModelPhotosCell.swift
//  qwert
//
//  Created by Anastasia on 24.11.21.
//

import UIKit

protocol ViewModelPhotosCellProtocol {
    var album: String { get }
}

class ViewModelPhotosCell: ViewModelPhotosCellProtocol {
    
    init(album: Album) {
        self.albums = album
    }

    var album: String {
        String(describing: albums.title)
    }

    // MARK: Private

    private var albums: Album

    
}
