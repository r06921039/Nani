//
//  DetailCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/3/28.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
//    var meal: Meal? {
//        didSet {
//            nameLabel.text = meal?.name
//            infoLabel.text = meal?.description
//            dollarLabel.text = "$\(meal?.price ?? 0.00)"
//        }
//    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Comfortaa-Light", size: 14)
        label.text = "Free strawberries and blueberries on the side for first 10 orders! Muffins are available in both savoury varieties, such as cornmeal and cheese muffins, or sweet varieties."
        label.numberOfLines = 5
        return label
    }()
    var topSeperator: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        return line
    }()
//    var infoLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .gray
//        label.font = UIFont.italicSystemFont(ofSize: 11)
//        label.text = "Carrot, beet, cucumber, romaine, lemon, genger, and cayenne pepper. Certified Organic. 16 oz bottle"
//        return label
//    }()
//    var dollarLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .gray
//        label.font = UIFont.italicSystemFont(ofSize: 11)
//        label.text = "$11.00"
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = .white
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            nameLabel.heightAnchor.constraint(equalToConstant: 70)
            ])
        addSubview(topSeperator)
        NSLayoutConstraint.activate([
            topSeperator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            topSeperator.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            topSeperator.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            topSeperator.heightAnchor.constraint(equalToConstant: 0.5)
            ])
//        addSubview(infoLabel)
//        NSLayoutConstraint.activate([
//            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
//            infoLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
//            infoLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
//            infoLabel.heightAnchor.constraint(equalToConstant: 20)
//            ])
//        addSubview(dollarLabel)
//        NSLayoutConstraint.activate([
//            dollarLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5),
//            dollarLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
//            dollarLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
//            dollarLabel.heightAnchor.constraint(equalToConstant: 20)
//            ])
    }
}

