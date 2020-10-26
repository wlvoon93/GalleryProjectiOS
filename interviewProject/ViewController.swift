//
//  ViewController.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 20/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var topImageHeightValue = 400
    var initialTopImageHeightValue = 400
    
    
    let aTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .gray
        
        return tableView
    }()
    
    let topImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "whale_image"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let tableBackgroundView: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        return v
    }()
    
    let galleryButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.yellow
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
//        aTableView.tableHeaderView = UIView(frame: frame)
        aTableView.contentInset = UIEdgeInsets(top: CGFloat(initialTopImageHeightValue), left: 0, bottom: 0, right: 0)
        aTableView.backgroundView = tableBackgroundView
        aTableView.separatorColor = .clear
        
        aTableView.dataSource = self
        aTableView.delegate = self

        constructHierarchy()
        activateConstraints()
        
        galleryButton.addTarget(self, action: #selector(self.showGallery), for: .touchUpInside) 
    }
    
    @objc func showGallery() {
        let pop = GalleryViewController()
        pop.homeViewController = self
        pop.modalPresentationStyle = .fullScreen
//        self.view.addSubview(pop.view)
        self.present(pop, animated: true, completion: nil)
    }
    
    func constructHierarchy(){
        view.addSubview(topImageView)
        self.view.addSubview(aTableView)
        self.view.bringSubviewToFront(topImageView)
        view.addSubview(galleryButton)
        self.view.bringSubviewToFront(galleryButton)
    }
    
    func activateConstraints(){
        
        activateConstraintsTableView()
        activateConstraintsTopImageView()
        activateConstraintsGalleryButton()
    }
}

// layout
extension ViewController{
    func activateConstraintsTableView() {
        aTableView.translatesAutoresizingMaskIntoConstraints = false
        let leading = aTableView.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
        let trailing = aTableView.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
        let top = aTableView.topAnchor
            .constraint(equalTo: self.view.topAnchor)
        let bottom = aTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, bottom])
    }
    
    func activateConstraintsTopImageView(){
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        let leading = topImageView.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
        let trailing = topImageView.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
        let top = topImageView.topAnchor
            .constraint(equalTo: self.view.topAnchor)
        let topImageHeight = topImageView.heightAnchor.constraint(equalToConstant: CGFloat(topImageHeightValue))
        topImageHeight.identifier = "imageheight"
        NSLayoutConstraint.activate(
            [leading, trailing, top, topImageHeight])
    }
    
    func activateConstraintsGalleryButton(){
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        
        let centerY = galleryButton.centerYAnchor
            .constraint(equalTo: topImageView.bottomAnchor)
        
        let leading = galleryButton.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor, constant: 10)
        let trailing = galleryButton.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor, constant: -10)
//        let bottom = aTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let height = galleryButton.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate(
            [centerY, trailing, leading, height])
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 11
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell
        
        cell = tableViewCell()

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }

    func styleCell(forIndexPath indexPath: IndexPath, cell: UITableViewCell?) {
       
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = initialTopImageHeightValue - (Int(scrollView.contentOffset.y) + initialTopImageHeightValue)
        let height = min(max(y, 60), 350)
        
        for constraint in self.topImageView.constraints {
            if constraint.identifier == "imageheight" {
                constraint.constant = CGFloat(height)
            }
        }
        self.view.layoutIfNeeded()
    }
    
}
