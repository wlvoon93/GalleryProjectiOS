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
    var homeViewController: ViewController?
    
    var indicatorStayLeft: NSLayoutConstraint?
    var indicatorStayRight: NSLayoutConstraint?
    
    var pageIndicatorConstraint: CGFloat?
    
    var indexPaths: [IndexPath] = Array<IndexPath>()

    let exitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.clear
        button.setBackgroundImage(#imageLiteral(resourceName: "cross-img"), for: .normal)
        return button
    }()
    
    let exitButtonBackgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.lightGray
        v.layer.cornerRadius = 15
        return v
    }()
    
    var bigButtonFontSize = 20
    var smallButtonFontSize = 15
    
    let albumOneLabel: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.clear
        button.setTitle("封面", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(20))
        return button
    }()
    
    let albumTwoLabel: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.clear
        button.setTitle("其他", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(15))
        return button
    }()
    
    let albumLabelsView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.clear
        return v
    }()
    
    let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(rgb: 0x333333)
        return v
    }()
    
    let pagingIndicator: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.yellow
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
        
        animateIn()
    }
    
    func movePageIndicator(index:Int){
        
        if index == 0 {
            indicatorStayLeft?.isActive = true
            indicatorStayRight?.isActive = false
            self.albumOneLabel.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(bigButtonFontSize))
            self.albumTwoLabel.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(smallButtonFontSize))
        }else{
            indicatorStayLeft?.isActive = false
            indicatorStayRight?.isActive = true
            self.albumTwoLabel.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(bigButtonFontSize))
            self.albumOneLabel.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(smallButtonFontSize))
        }
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc fileprivate func animateOut(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.view.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        } completion: { (complete) in
            if complete {
//                self.view.removeFromSuperview()
//                self.dismiss(animated: false, completion: nil)
                self.homeViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc fileprivate func animateIn(){
        
        self.view.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        self.view.alpha = 0
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.view.transform = .identity
            self.view.alpha = 1
        }
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
        
        exitButton.addTarget(self, action: #selector(animateOut), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _ = networkHelper.getImages().done { (images) in
            self.imagesDetails = images
            self.pagingCollectionView?.reloadData()
        }
    }
    
    func constructHierarchy(){
        view.addSubview(contentView)
        contentView.addSubview(exitButtonBackgroundView)
        exitButtonBackgroundView.addSubview(exitButton)
        
        contentView.addSubview(albumLabelsView)
        contentView.addSubview(pagingCollectionView ?? UICollectionView())
        
        albumLabelsView.addSubview(albumOneLabel)
        albumLabelsView.addSubview(albumTwoLabel)
        
        contentView.addSubview(pagingIndicator)
    }
    
    func activateConstraints(){
        
        activateConstraintsContentView()
        activateConstraintsExitButtonBackgroundView()
        activateConstraintsExitButton()
        activateConstraintsAlbumLabelsView()
        activateConstraintsPagingCollectionView()
        
        activateConstraintsAlbumOneLabel()
        activateConstraintsAlbumTwoLabel()
        
        activateConstraintsPagingIndicator()
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
        let centerX = exitButton.centerXAnchor
            .constraint(equalTo: self.exitButtonBackgroundView.centerXAnchor)
        let centerY = exitButton.centerYAnchor
            .constraint(equalTo: self.exitButtonBackgroundView.centerYAnchor)
        let height = exitButton.heightAnchor
            .constraint(equalToConstant: 20)
        let width = exitButton.widthAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate(
            [centerX, height, centerY, width])
    }
    
    func activateConstraintsAlbumLabelsView(){
        albumLabelsView.translatesAutoresizingMaskIntoConstraints = false
        let centerX = albumLabelsView.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        let top = albumLabelsView.topAnchor
            .constraint(equalTo: self.view.topAnchor, constant: 40)
        let bottom = albumLabelsView.bottomAnchor
            .constraint(equalTo: albumOneLabel.bottomAnchor)

        NSLayoutConstraint.activate(
            [centerX, top, bottom])
    }
    
    func activateConstraintsAlbumOneLabel() {
        albumOneLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = albumOneLabel.leadingAnchor
            .constraint(equalTo: self.albumLabelsView.leadingAnchor)
        let top = albumOneLabel.topAnchor
            .constraint(equalTo: self.albumLabelsView.topAnchor)
        let height = albumOneLabel.heightAnchor.constraint(equalToConstant: 30)
        
        NSLayoutConstraint.activate(
            [leading, top, height])
    }
    
    func activateConstraintsAlbumTwoLabel() {
        albumTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = albumTwoLabel.leadingAnchor
            .constraint(equalTo: albumOneLabel.trailingAnchor, constant: 30)
        let trailing = albumTwoLabel.trailingAnchor
            .constraint(equalTo: self.albumLabelsView.trailingAnchor)
        let top = albumTwoLabel.topAnchor
            .constraint(equalTo: self.albumLabelsView.topAnchor)
        let height = albumTwoLabel.heightAnchor.constraint(equalToConstant: 30)
        
        NSLayoutConstraint.activate(
            [leading, trailing, top, height])
    }
    
    func activateConstraintsPagingCollectionView(){
        pagingCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        let leading = pagingCollectionView!.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
        let trailing = pagingCollectionView!.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
        let top = pagingCollectionView!.topAnchor
            .constraint(equalTo: self.albumLabelsView.bottomAnchor, constant: 10)
        let bottom = pagingCollectionView!.bottomAnchor
            .constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, bottom])
    }
    
    func activateConstraintsPagingIndicator(){
        pagingIndicator.translatesAutoresizingMaskIntoConstraints = false
        let centerX = pagingIndicator.centerXAnchor
            .constraint(equalTo: self.albumOneLabel.centerXAnchor)
        self.indicatorStayLeft = centerX
        let centerY = pagingIndicator.centerXAnchor
            .constraint(equalTo: self.albumTwoLabel.centerXAnchor)
        self.indicatorStayRight = centerY
        pageIndicatorConstraint = centerX.constant
        let width = pagingIndicator.widthAnchor
            .constraint(equalTo: albumOneLabel.widthAnchor)
        let top = pagingIndicator.topAnchor
            .constraint(equalTo: self.albumLabelsView.bottomAnchor)
        let height = pagingIndicator.heightAnchor
            .constraint(equalToConstant: 3)
        NSLayoutConstraint.activate(
            [centerX, width, top, height])
    }
    
    func activateConstraintsExitButtonBackgroundView(){
        exitButtonBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        let leading = exitButtonBackgroundView.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor, constant: 20)
        let top = exitButtonBackgroundView.topAnchor
            .constraint(equalTo: self.view.topAnchor, constant: 40)
        let height = exitButtonBackgroundView.heightAnchor
            .constraint(equalToConstant: 30)
        let width = exitButtonBackgroundView.widthAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate(
            [leading, height, top, width])
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
        print("current page \(pageControl.currentPage)")
        
   
        movePageIndicator(index: pageControl.currentPage)

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
