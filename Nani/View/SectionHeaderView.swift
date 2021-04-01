//
//  SectionHeaderView.swift
//  Nani
//
//  Created by Jeff on 2021/3/28.
//

import UIKit

class SectionHeaderView: UICollectionViewCell {
    
    var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Comfortaa-Bold", size: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        title = ""
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let leading : CGFloat = 15
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
}
