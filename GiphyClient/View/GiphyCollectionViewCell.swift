//
//  GiphyCollectionViewCell.swift
//  GiphyClient
//
//  Created by DEL on 17.10.2018.
//  Copyright © 2018 andrei zeniukevich. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class GiphyCollectionViewCell: UICollectionViewCell {
    
    var imageView: AnimatedImageView {
        let imageView = AnimatedImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    var viewModel: GiphyModel! {
        didSet {
            guard let imageURL = viewModel.gif?.url else { return }
            imageView.kf.setImage(with: imageURL)
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.kf.indicatorType = .activity
        contentView.addSubview(imageView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
