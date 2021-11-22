//
//  PhotoVC.swift
//  qwert
//
//  Created by Anastasiya on 19.11.21.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageVC: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = photo?.title
        getPhoto()
    }
    
    func getPhoto() {
        if let photoURL = photo?.url {
            activityIndicator.startAnimating()
            if let image = CacheManager.shared.imageCache.image(withIdentifier: photoURL) {
                activityIndicator.stopAnimating()
                photoImage.image = image
            } else {
                AF.request(photoURL).responseImage { [weak self] response in
                    if case .success(let image) = response.result {
                        self?.activityIndicator.stopAnimating()
                        self?.photoImage.image = image
                        CacheManager.shared.imageCache.add(image, withIdentifier: photoURL)
                    }
                }
            }
        }
    }
}

