//
//  PhotoDetailViewController.swift
//  BTPexel
//
//  Created by Ilia Baudin on 30.07.2024.
//

import UIKit
import PexelDomain
import SDWebImage

/// Detail View Controller for presenting all detail about selected post
class PhotoDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var photoView: UIImageView!
    
    var photo: PexelPhoto?
    
    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupController()
    }
    
    // MARK: - Private methods
    /// Configure controller content with selected photo
    private func setupController() {
        guard let photo,
            let photoURL = URL(string: photo.photoUrl) else {
            print("Error: PhotoDetailViewController, photoURL is nil")
            return
        }
        photoView.sd_setImage(with: photoURL)
    }
}
