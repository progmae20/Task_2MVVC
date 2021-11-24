//
//  ViewModelAlbumsCellVC.swift
//  qwert
//
//  Created by Anastasia on 23.11.21.
//

import UIKit

protocol ViewModelAlbumsVCProtocol {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ViewModelAlbumsCellProtocol?

    func selectRow(atIndexPath indexPath: IndexPath)
    func getAlboms(clouser: @escaping(Error?) -> ())
//    func viewModelForSelectedRow() -> PhotosCollectionVC?
}
    
class ViewModelAlbumsVC: ViewModelAlbumsVCProtocol {
    
    func numberOfRows() -> Int {
        albums.count
    }
    
    init(user: User) {
        self.user = user
    }

    // создание новой TableViewCellViewModel
    func cellViewModel(forIndexPath indexPath: IndexPath) -> ViewModelAlbumsCellProtocol? {
        let album = albums[indexPath.row]
        // одна модель порождает вторую Veiw Model
        return ViewModelAlbumsCell(album: album)
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

//    func viewModelForSelectedRow() -> PhotosCollectionVC? {
//        guard let selectedIndexPath = selectedIndexPath else { return nil }
//        return PhotosCollectionVC(coder: albums[selectedIndexPath.row])
//    }
    
    func getAlboms(clouser: @escaping(Error?) -> ()) {
        
        guard let userId = user.id else { return }
        let pathUrl = "\(ApiConstants.albumsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.albums = try JSONDecoder().decode([Album].self, from: data)
                clouser(nil)
            } catch let error {
                clouser(error)
            }
        }
        
        task.resume()
    }

    // MARK: Private

    private var selectedIndexPath: IndexPath?
    
    var user: User
    
    private var albums: [Album] = []

}
