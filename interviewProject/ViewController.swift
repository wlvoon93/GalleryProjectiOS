//
//  ViewController.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 20/10/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var topImageHeightValue = 300
    var initialTopImageHeightValue = 100
    
    let aTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self,
            forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        
        return tableView
    }()
    
    let topImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "whale_image"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
        aTableView.tableHeaderView = UIView(frame: frame)
        aTableView.contentInset = UIEdgeInsets(top: CGFloat(initialTopImageHeightValue), left: 0, bottom: 0, right: 0)
        
        aTableView.dataSource = self
        aTableView.delegate = self

        constructHierarchy()
        activateConstraints()
        
        let pop = GalleryViewController()
        self.view.addSubview(pop.view)
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
            .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
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
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//
//        return 0.01
//    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 11
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell
        
        cell = tableViewCell()
        

//        if indexPath.row == 0 || indexPath.row == 3 {
//            cell = ProfileHeaderCellTableViewCell()
////        cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell.rawValue)!
////        cell.textLabel?.text = content(forIndexPath: indexPath)
//            let headerCell:ProfileHeaderCellTableViewCell = cell as! ProfileHeaderCellTableViewCell
//            headerCell.myLabel.text = content(forIndexPath: indexPath)
//            styleCell(forIndexPath: indexPath, cell: cell)
//        } else {
//            cell = ProfileBodyCellTableViewCell()
//
//            let bodyCell:ProfileBodyCellTableViewCell = cell as! ProfileBodyCellTableViewCell
////            bodyCell.cellLabelString = content(forIndexPath: indexPath)
//            bodyCell.myLabel.text = content(forIndexPath: indexPath)
////            cell.textLabel?.text = content(forIndexPath: indexPath)
//            styleCell(forIndexPath: indexPath, cell: cell)
//        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }

    func styleCell(forIndexPath indexPath: IndexPath, cell: UITableViewCell?) {
       
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = initialTopImageHeightValue - (Int(scrollView.contentOffset.y) + initialTopImageHeightValue)
        let height = min(max(y, 60), 400)
        
//        topImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        print(height)
        
        for constraint in self.topImageView.constraints {
            if constraint.identifier == "imageheight" {
                constraint.constant = CGFloat(height)
            }
        }
        self.view.layoutIfNeeded()
        
        
//        topImageHeight = topImageView.heightAnchor.constraint(equalToConstant: height)
//        NSLayoutConstraint.activate(
//            [topImageHeight])}
//        self.view.layoutIfNeeded()
    }
    
}
