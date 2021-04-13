//
//  EmptyReviewCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/4/13.
//

import UIKit

class EmptyReviewCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){}
    
}
