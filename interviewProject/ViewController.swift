//
//  ViewController.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 20/10/2020.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .gray

        return view
    }()
    
    let imageContainer = UIView()
    let textContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }()

    let textContent: UIView = {
        let view = UIView()
        view.backgroundColor = .blue

        return view
    }()

//    private let infoText = UILabel()

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
//
//        infoText.textColor = .black
//        infoText.numberOfLines = 0
//        let text =  """
//                    Lorem ipsum dolor sit amet, in alia adhuc aperiri nam. Movet scripta tractatos cu eum, sale commodo meliore ea eam, per commodo atomorum ea. Unum graeci iriure nec an, ea sit habeo movet electram. Id eius assum persius pro, id cum falli accusam. Has eu fierent partiendo, doming expetenda interesset cu mel, tempor possit vocent in nam. Iusto tollit ad duo, est at vidit vivendo liberavisse, vide munere nonumy sed ex.
//
//                    Quod possit expetendis id qui, consequat vituperata ad eam. Per cu elit latine vivendum. Ei sit nullam aliquam, an ferri epicuri quo. Ex vim tibique accumsan erroribus. In per libris verear adipiscing. Purto aliquid lobortis ea quo, ea utinam oportere qui.
//                    """
//        infoText.text = text + text + text

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

    func constructHierarchy() {

        view.addSubview(scrollView)
        scrollView.addSubview(imageContainer)
        scrollView.addSubview(textContainer)
        scrollView.addSubview(topImageView)

        scrollView.addSubview(galleryButton)

        textContainer.addSubview(textContent)

//        view.addSubview(topImageView)
//        self.view.bringSubviewToFront(topImageView)
//        view.addSubview(galleryButton)
//        self.view.bringSubviewToFront(galleryButton)
    }

    func activateConstraints() {
        activateConstraintScrollView()
        activateConstraintsTopImageView()
        activateConstraintsGalleryButton()
        activateConstraintImageContainer()

        activateConstraintTextContainer()
        activateConstraintTextContent()
    }
}

// layout
extension ViewController {

    func activateConstraintScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let leading = scrollView.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
        let trailing = scrollView.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
        let top = scrollView.topAnchor
            .constraint(equalTo: self.view.topAnchor)
        let bottom = scrollView.bottomAnchor
            .constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, bottom])
    }

    func activateConstraintsGalleryButton() {
        galleryButton.translatesAutoresizingMaskIntoConstraints = false
        let width = galleryButton.widthAnchor
            .constraint(equalToConstant: 300)
        let height = galleryButton.heightAnchor
            .constraint(equalToConstant: 50)
        let centerX = galleryButton.centerXAnchor
            .constraint(equalTo: topImageView.centerXAnchor)
        let centerY = galleryButton.centerYAnchor
            .constraint(equalTo: topImageView.bottomAnchor)
        NSLayoutConstraint.activate(
            [width, height, centerX, centerY])
    }

    func activateConstraintImageContainer() {
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        let leading = imageContainer.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
        let trailing = imageContainer.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
        let top = imageContainer.topAnchor
            .constraint(equalTo: scrollView.topAnchor)
        let height = imageContainer.heightAnchor
            .constraint(equalTo: imageContainer.widthAnchor, multiplier: 0.7)
        NSLayoutConstraint.activate(
            [leading, trailing, top, height])
    }

    func activateConstraintsTopImageView() {
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        let leading = topImageView.leadingAnchor
            .constraint(equalTo: imageContainer.leadingAnchor)
        let trailing = topImageView.trailingAnchor
            .constraint(equalTo: imageContainer.trailingAnchor)

        let top = topImageView.topAnchor
            .constraint(equalTo: self.view.topAnchor)
        top.priority = .required
        top.isActive = true
//
//        let initialHeight = imageView.heightAnchor
//            .constraint(equalToConstant: 500)
//        initialHeight.priority = .defaultHigh // was top
//        initialHeight.isActive = true // was top

        let height = topImageView.heightAnchor
            .constraint(greaterThanOrEqualTo: imageContainer.heightAnchor, constant: -200)
        height.priority = .required // was top
        height.isActive = true // was top

        let bottom = topImageView.bottomAnchor
            .constraint(equalTo: imageContainer.bottomAnchor)
//        make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
        NSLayoutConstraint.activate(
            [leading, trailing, top, height, bottom])
    }

    func activateConstraintTextContainer() {
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        let leading = textContainer.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor)
        let trailing = textContainer.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor)
        let top = textContainer.topAnchor
            .constraint(equalTo: imageContainer.bottomAnchor)
        let bottom = textContainer.bottomAnchor
            .constraint(equalTo: scrollView.bottomAnchor)
//        make.height.equalTo(imageContainer.snp.width).multipliedBy(0.7)
        NSLayoutConstraint.activate(
            [leading, trailing, top, bottom])
    }


    func activateConstraintTextContent() {
        textContent.translatesAutoresizingMaskIntoConstraints = false
        let leading = textContent.leadingAnchor
            .constraint(equalTo: textContainer.leadingAnchor, constant: 20)
        let trailing = textContent.trailingAnchor
            .constraint(equalTo: textContainer.trailingAnchor, constant: -20)
        let top = textContent.topAnchor
            .constraint(equalTo: textContainer.topAnchor, constant: 50)
        let height = textContent.heightAnchor
            .constraint(equalToConstant: 900)
        let bottom = textContent.bottomAnchor
            .constraint(equalTo: textContainer.bottomAnchor, constant: -50)
        NSLayoutConstraint.activate(
            [leading, trailing, top, bottom, height])
    }



}

