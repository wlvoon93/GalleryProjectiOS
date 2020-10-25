//
//  ImageCell.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 24/10/2020.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
    
    
    let galleryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(galleryImageView)
        
        self.activateConstraintsGalleryImageView()
    }
    
    func activateConstraintsGalleryImageView(){
        galleryImageView.translatesAutoresizingMaskIntoConstraints = false
        let leading = galleryImageView.leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
        let trailing = galleryImageView.trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
        let top = galleryImageView.topAnchor
            .constraint(equalTo: self.topAnchor)
        let bottom = galleryImageView.bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate(
            [leading, bottom, top, trailing])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
