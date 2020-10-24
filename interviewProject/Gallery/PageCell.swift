//
//  PageCell.swift
//  SwipingTest
//
//  Created by Voon Wei Liang on 24/10/2020.
//

import Foundation
import UIKit

class PageCell: UICollectionViewCell {
    
    let exitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.yellow
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple
        
        self.addSubview(exitButton)
        
        self.activateConstraintsExitButton()
    }
    
    func activateConstraintsExitButton(){
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        let leading = exitButton.leadingAnchor
            .constraint(equalTo: self.leadingAnchor, constant: 20)
        let top = exitButton.topAnchor
            .constraint(equalTo: self.topAnchor, constant: 20)
        let height = exitButton.heightAnchor
            .constraint(equalToConstant: 30)
        let width = contentView.widthAnchor.constraint(equalToConstant: height.constant)
        NSLayoutConstraint.activate(
            [leading, height, top, width])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
