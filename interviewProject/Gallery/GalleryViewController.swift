//
//  galleryViewController.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 24/10/2020.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {
    
    let numberOfPages = 2
    var pagingCollectionView:UICollectionView?
    var firstPage: UICollectionViewCell?
    var secondPage: UICollectionViewCell?
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var imagesDetails:[Image]?
    
    var indexPaths: [IndexPath] = Array<IndexPath>()

    let exitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    let albumOneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.green
        button.setTitle("封面", for: .normal)
        return button
    }()
    
    let albumTwoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        button.setTitle("其他", for: .normal)
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
    
    let networkHelper = NetworkHelper()

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
        wireController()
        
    }
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 2
        pc.currentPageIndicatorTintColor = .blue
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    func wireController(){
        albumOneButton.addTarget(self, action: #selector(gotoPageOne), for: .touchUpInside)
        albumTwoButton.addTarget(self, action: #selector(gotoPageTwo), for: .touchUpInside)
    }
    
    @objc private func gotoPageOne(){
//        let indexPath = IndexPath(item: 0, section: 0)
//        pagingCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        let nextIndex = min(pageControl.currentPage - 1, 2 - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        pagingCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func gotoPageTwo(){
        
//        let indexPath = indexPaths[1]
//        pagingCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let nextIndex = min(pageControl.currentPage + 1, 2 - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        pagingCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        _ = networkHelper.getImages().done { (images) in
            self.imagesDetails = images
            self.pagingCollectionView?.reloadData()
        }
    }
    
    func constructHierarchy(){
        view.addSubview(contentView)
        contentView.addSubview(exitButton)
        contentView.addSubview(albumButtonsView)
        contentView.addSubview(pagingCollectionView ?? UICollectionView())
        
        albumButtonsView.addSubview(albumOneButton)
        albumButtonsView.addSubview(albumTwoButton)
    }
    
    func activateConstraints(){
        
        activateConstraintsContentView()
        activateConstraintsExitButton()
        activateConstraintsAlbumButtonsView()
        activateConstraintsPagingCollectionView()
        
        activateConstraintsAlbumOneButton()
        activateConstraintsAlbumTwoButton()
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
            .constraint(equalTo: self.view.topAnchor, constant: 40)
        let bottom = albumButtonsView.bottomAnchor
            .constraint(equalTo: albumOneButton.bottomAnchor)

        NSLayoutConstraint.activate(
            [centerX, top, bottom])
    }
    
    func activateConstraintsAlbumOneButton() {
        albumOneButton.translatesAutoresizingMaskIntoConstraints = false
        let leading = albumOneButton.leadingAnchor
            .constraint(equalTo: self.albumButtonsView.leadingAnchor)
        let top = albumOneButton.topAnchor
            .constraint(equalTo: self.albumButtonsView.topAnchor)
        
        NSLayoutConstraint.activate(
            [leading, top])
    }
    
    func activateConstraintsAlbumTwoButton() {
        albumTwoButton.translatesAutoresizingMaskIntoConstraints = false
        let leading = albumTwoButton.leadingAnchor
            .constraint(equalTo: albumOneButton.trailingAnchor, constant: 30)
        let trailing = albumTwoButton.trailingAnchor
            .constraint(equalTo: self.albumButtonsView.trailingAnchor)
        let top = albumTwoButton.topAnchor
            .constraint(equalTo: self.albumButtonsView.topAnchor)
        
        NSLayoutConstraint.activate(
            [leading, trailing, top])
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
        return numberOfPages // How many cells to display
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        let pageCell:PageCell = myCell as! PageCell
        
        if self.imagesDetails != nil {
            if self.imagesDetails!.count > 0 {
                let splitArray = self.imagesDetails?.split()
                var halfArray:[Image]
                
                if indexPath.row == 0 {
                    halfArray = splitArray!.left
                }else{
                    halfArray = splitArray!.right
                }
                pageCell.setImageDetails(imageDetails: halfArray)
            }
        }
        
        indexPaths.append(indexPath)
        
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


extension Array {
    func split() -> (left: [Element], right: [Element]) {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return (left: Array(leftSplit), right: Array(rightSplit))
    }
}
