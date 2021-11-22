//
//  PhotosVC.swift
//  qwert
//
//  Created by Anastasiya on 18.11.21.
//

import UIKit

class PhotosCollectionVC: UICollectionViewController {
    
    var album: Album?
    private var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.configure(photo: photo)
        return cell
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPhotoVC", sender: photos[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let desination = segue.destination as? ImageVC,
           let photo = sender as? Photo {
            desination.photo = photo
        }
    }
    
    private func getPhotos() {
        
        guard let albumsId = album?.id else { return }
        let pathUrl = "\(ApiConstants.photosPath)?albumId=\(albumsId)"

        guard let url = URL(string: pathUrl) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            guard let data = data else { return }
            do {
                self?.photos = try JSONDecoder().decode([Photo].self, from: data)
                print(self?.photos[0])
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        
        task.resume()
    }
}
