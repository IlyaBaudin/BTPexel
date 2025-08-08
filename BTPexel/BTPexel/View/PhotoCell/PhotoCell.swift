//
//  PhotoCell.swift
//  BTPexel
//
//  Created by Ilia Baudin on 26.07.2024.
//

import UIKit
import protocol PexelSDK.PexelPhotoProtocol
import SDWebImage

/// PhotoCell item for UITableView that contains a list of photo posts
class PhotoCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var shadowView: ShadowView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var photoView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
        
    // MARK: - NSObject
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Public methods
    /// Configure cell with photo object that contains all required fields to present it to user
    /// - Parameter photo: object that represents photo item
    public func configureCell(photo: PexelPhotoProtocol) {
        titleLabel.text = photo.photoTitle
        authorLabel.text = photo.authorName
        
        guard let url = URL(string: photo.photoUrl) else {
            photoView.image = nil
            return
        }
        
        let targetSize = CGSize(
            width: max(1, photoView.bounds.width * UIScreen.main.scale),
            height: max(1, photoView.bounds.height * UIScreen.main.scale)
        )
        
        let transformer = SDImageResizingTransformer(size: targetSize, scaleMode: .aspectFill)
        
        photoView.sd_setImage(
            with: url,
            placeholderImage: nil,
            options: [.scaleDownLargeImages, .retryFailed, .continueInBackground],
            context: [.imageTransformer: transformer]
        )
    }
    
    public func cancelImageLoad() {
        photoView.sd_cancelCurrentImageLoad()
    }
    
    // MARK: - Private methods
    /// Setup UI for cell on loading cell from .xib
    private func setupUI() {
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
        shadowView.layer.cornerRadius = 8
        shadowView.layer.masksToBounds = false
    }
    
    
    // MARK: - UITableViewCell
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoad()
        photoView.image = nil
        titleLabel.text = nil
        authorLabel.text = nil
    }
}
