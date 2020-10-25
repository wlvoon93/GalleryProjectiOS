//
//  PageCell.swift
//  SwipingTest
//
//  Created by Voon Wei Liang on 24/10/2020.
//

import Foundation
import UIKit
import SDWebImage

class PageCell: UICollectionViewCell {

    var galleryCollectionView: UICollectionView?
    var imageDetails:[Image] = Array<Image>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-1, height: UIScreen.main.bounds.width/3-1)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0);

        galleryCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        galleryCollectionView?.register(ImageCell.self, forCellWithReuseIdentifier: "MyCell")
        galleryCollectionView?.backgroundColor = UIColor.white

        galleryCollectionView?.dataSource = self
        galleryCollectionView?.delegate = self

        galleryCollectionView?.isPagingEnabled = true


        self.addSubview(galleryCollectionView ?? UICollectionView())

        self.activateGalleryCollectionView()
    }

    func setImageDetails(imageDetails: [Image]){
        self.imageDetails = imageDetails
        
        self.galleryCollectionView?.reloadData()
    }

    func activateGalleryCollectionView() {
        galleryCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        let leading = galleryCollectionView!.leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
        let trailing = galleryCollectionView!.trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
        let top = galleryCollectionView!.topAnchor
            .constraint(equalTo: self.topAnchor, constant: 40)
        let bottom = galleryCollectionView!.bottomAnchor
            .constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, bottom])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDetails.count // How many cells to display
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        let imageCell: ImageCell = myCell as! ImageCell
        let imageDetail = imageDetails[indexPath.row]
        let urlString = imageDetail.download_url
        
        if let unwrappedURL: String = urlString {
            imageCell.galleryImageView.sd_internalSetImage(with: URL(string: unwrappedURL), placeholderImage: nil, options: .waitStoreCache, context: nil, setImageBlock: nil, progress: { (progress, completed, url) in
//                print("\(progress) \(completed) \(url)")
            }, completed: nil)
        }
        
        return myCell
    }


}
extension PageCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }

}

extension PageCell: UICollectionViewDelegateFlowLayout {


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
