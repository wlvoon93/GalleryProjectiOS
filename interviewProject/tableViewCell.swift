//
//  tableViewCell.swift
//  interviewProject
//
//  Created by Voon Wei Liang on 20/10/2020.
//

import UIKit

public class tableViewCell: UITableViewCell {

    fileprivate let newContentView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.contentView.backgroundColor = .clear

        self.contentView.addSubview(newContentView)
        newContentView.backgroundColor = .blue
        
        newContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            newContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            newContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            newContentView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 0),
            newContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            ])
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
