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
    
    public var viewModel: PhotoDetailViewModel!
    
    // MARK: - UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        photoView.sd_cancelCurrentImageLoad()
        SDWebImageManager.shared.cancelAll()
    }
    
    // MARK: - Private methods
    /// Configure controller content with selected photo
    private func setupController() {
        
        photoView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        
        if let preview = viewModel.previewUrl {
            photoView.sd_setImage(
                with: preview,
                placeholderImage: photoView.image,
                options: [.scaleDownLargeImages, .retryFailed]
            )
        } else {
            photoView.image = nil
        }
        
        if let hiResUrl = viewModel.hiResUrl {
            SDWebImageManager.shared.loadImage(
                with: hiResUrl,
                options: [.highPriority, .progressiveLoad, .retryFailed, .avoidAutoSetImage],
                progress: nil) { [weak self] image, _, error, _, finished, _ in
                    guard let self, finished, error == nil, let image else { return }
                    UIView.transition(
                        with: self.photoView,
                        duration: 0.2,
                        options: .transitionCrossDissolve,
                        animations: { self.photoView.image = image },
                        completion: nil
                    )
                }
        }
    }
}
