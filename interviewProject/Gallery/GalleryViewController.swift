//
//  galleryViewController.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 24/10/2020.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {
    
    var pagingCollectionView:UICollectionView?
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

    let exitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    let albumOneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.green
        return button
    }()
    
    let albumTwoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        return button
    }()
    
    let albumButtonsView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.blue
        v.layer.cornerRadius = 24
        return v
    }()
    
    let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(rgb: 0x333333)
        v.layer.cornerRadius = 24
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .gray
//        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.view.frame = UIScreen.main.bounds
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        
        pagingCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        pagingCollectionView?.register(PageCell.self, forCellWithReuseIdentifier: "MyCell")
        pagingCollectionView?.backgroundColor = UIColor.white

        pagingCollectionView?.dataSource = self
        pagingCollectionView?.delegate = self

        pagingCollectionView?.isPagingEnabled = true

        constructHierarchy()
        activateConstraints()
    }
    
    func constructHierarchy(){
        view.addSubview(contentView)
        contentView.addSubview(exitButton)
        contentView.addSubview(albumButtonsView)
        contentView.addSubview(pagingCollectionView ?? UICollectionView())
    }
    
    func activateConstraints(){
        
        activateConstraintsContentView()
        activateConstraintsExitButton()
        activateConstraintsAlbumButtonsView()
        activateConstraintsPagingCollectionView()
    }
}

// layout
extension GalleryViewController{
    func activateConstraintsContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let leading = contentView.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
        let top = contentView.topAnchor
            .constraint(equalTo: self.view.topAnchor)
        let bottom = contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, bottom])
    }
    
    func activateConstraintsExitButton(){
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        let leading = exitButton.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let top = exitButton.topAnchor
            .constraint(equalTo: self.view.topAnchor, constant: 20)
        let height = exitButton.heightAnchor
            .constraint(equalToConstant: 30)
        let width = contentView.widthAnchor.constraint(equalToConstant: height.constant)
        NSLayoutConstraint.activate(
            [leading, height, top, width])
    }
    
    func activateConstraintsAlbumButtonsView(){
        albumButtonsView.translatesAutoresizingMaskIntoConstraints = false
        let centerX = albumButtonsView.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        let top = albumButtonsView.topAnchor
            .constraint(equalTo: self.view.topAnchor, constant: 20)
        let height = albumButtonsView.heightAnchor
            .constraint(equalToConstant: 50)
        let width = albumButtonsView.widthAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate(
            [centerX, height, top, width])
    }
    
    func activateConstraintsPagingCollectionView(){
        pagingCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        let leading = pagingCollectionView!.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
        let trailing = pagingCollectionView!.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
        let top = pagingCollectionView!.topAnchor
            .constraint(equalTo: self.albumButtonsView.bottomAnchor, constant: 10)
        let bottom = pagingCollectionView!.bottomAnchor
            .constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, bottom])
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 // How many cells to display
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
//        myCell.backgroundColor = UIColor.blue
        return myCell
    }

    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }


}
extension GalleryViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }

}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
