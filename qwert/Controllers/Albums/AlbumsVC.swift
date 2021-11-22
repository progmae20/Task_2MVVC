//
//  AlbumsVC.swift
//  qwert
//
//  Created by Anastasiya on 16.11.21.
//

import UIKit

class AlbumsVC: UITableViewController {
    
    var user: User?
    private var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlboms()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? PhotosCollectionVC,
           let album = sender as? Album {
            desination.album = album
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlbumsCellVC
        let album = albums[indexPath.row]
        cell.configure(albums: album)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPHotosVC", sender: albums[indexPath.row])
    }
    
    private func getAlboms() {
        
        guard let userId = user?.id else { return }
        let pathUrl = "\(ApiConstants.albumsPath)?userId=\(userId)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                self.albums = try JSONDecoder().decode([Album].self, from: data)
                print(self.albums)
            } catch let error {
                print(error)
            }
        }
        
        task.resume()
    }
}

