//
//  SectionTitleIndexController.swift
//  Nani
//
//  Created by Jeff on 2021/3/28.
//

import UIKit

class SectionTitleIndexCollectionView: UICollectionView {
    
    var sectionTitles: [String] = {
        let mls = Meal.loadMealSections()
        return mls
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SectionTitleIndexCollectionViewCell: UICollectionViewCell {
    
    var sectionTitle: String? {
        didSet {
            titleLabel.text = sectionTitle ?? "N/A"
        }
    }
    
    
    
    var titleLabelWidthConstraint: NSLayoutConstraint?
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Comfortaa-Regular", size: 16.0)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    var topSeperator: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = hexStringToUIColor(hex: "F0B357")
        return line
    }()
    
    
    override var isSelected: Bool {
        didSet {
            self.titleLabel.textColor = isSelected ? hexStringToUIColor(hex: "F0B357") : .black
            self.topSeperator.isHidden = isSelected ? false : true
        }
    }
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(titleLabel)
        titleLabelWidthConstraint = titleLabel.widthAnchor.constraint(equalTo: widthAnchor)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor),
            titleLabelWidthConstraint!,
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0)
            ])
        addSubview(topSeperator)
        NSLayoutConstraint.activate([
            topSeperator.bottomAnchor.constraint(equalTo:bottomAnchor, constant: 0),
            topSeperator.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            topSeperator.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            topSeperator.heightAnchor.constraint(equalToConstant: 1)
            ])
        self.topSeperator.isHidden = true
        
    }
}


