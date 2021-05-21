//
//  SectionHeaderView.swift
//  Nani
//
//  Created by Jeff on 2021/3/28.
//

import UIKit

class SectionHeaderView: UICollectionViewCell {
    
    var delegate : showAddReviewDelegate?
    
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
    
    lazy var addReviewButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Write a Review", for: .normal)
        button.titleLabel?.font = UIFont(name: "Comfortaa-Bold", size: 14.0)
        button.setTitleColor(hexStringToUIColor(hex: "#F0B357"), for: .normal)
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.isHidden = true
        return button
        }()
    
    @objc func pressed() {
        self.delegate?.showAddReview()
    }
    
    
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
//        NSLayoutConstraint.activate([
//            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
//            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
//            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
//            titleLabel.heightAnchor.constraint(equalToConstant: 50)
//            ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
            ])
        addSubview(addReviewButton)
        NSLayoutConstraint.activate([
            addReviewButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            addReviewButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            addReviewButton.widthAnchor.constraint(equalToConstant: 105),
            addReviewButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
}
