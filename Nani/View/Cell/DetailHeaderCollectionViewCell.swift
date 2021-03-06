//
//  DetailHeaderCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/3/28.
//

import UIKit

class DetailHeaderCollectionViewCell: UICollectionViewCell, CoverImageDelegate {
    
    var coverImageHeightConstraint: NSLayoutConstraint?
    var coverImageTopAnchorConstraint: NSLayoutConstraint?
    var coverImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "tennesse_taco_co_2") )
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(coverImageView)
        coverImageHeightConstraint = coverImageView.heightAnchor.constraint(equalToConstant: frame.width*0.79625)
        coverImageTopAnchorConstraint = coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        NSLayoutConstraint.activate([
            coverImageTopAnchorConstraint!,
            coverImageView.leftAnchor.constraint(equalTo: leftAnchor),
            coverImageView.rightAnchor.constraint(equalTo: rightAnchor),
            coverImageHeightConstraint!
            ])
    }
    func updateImageHeight(height: CGFloat) {
        coverImageHeightConstraint?.constant = height
    }
    func updateImageTopAnchorConstraint(constant: CGFloat) {
        coverImageTopAnchorConstraint?.constant = constant
    }
}

