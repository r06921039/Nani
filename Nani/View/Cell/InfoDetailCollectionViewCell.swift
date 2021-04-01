//
//  InfoDetailCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/3/31.
//

import UIKit

class InfoDetailCollectionViewCell: UICollectionViewCell {
    
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Comfortaa-Regular", size: 14)
        label.text = "Pick up between 8:30-10:00 am"
        return label
    }()
    
    var provideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Comfortaa-Regular", size: 14)
        label.text = "Plates provided"
        return label
    }()
    
    var containsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Comfortaa-Regular", size: 14)
        label.text = "Contains: Eggs, Milk"
        return label
    }()
    
    var dineInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Comfortaa-Regular", size: 14)
        label.text = "Dine-in available"
        return label
    }()
    
    let timeIcon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "store-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let provideIcon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "restaurant-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containsIcon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "local_dining-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dineInIcon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "room_service-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var topSeperator: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        return line
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        let height : CGFloat = 20
        let leading : CGFloat = 15
        let iconDistance : CGFloat = 10
        let labelDistance : CGFloat = 10
        let distance : CGFloat = 15
        backgroundColor = .white
        addSubview(timeIcon)
        NSLayoutConstraint.activate([
            timeIcon.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            timeIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            timeIcon.widthAnchor.constraint(equalToConstant: height),
            timeIcon.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo:topAnchor, constant: 0),
            timeLabel.leftAnchor.constraint(equalTo: timeIcon.rightAnchor, constant: distance),
            timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            timeLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(provideIcon)
        NSLayoutConstraint.activate([
            provideIcon.topAnchor.constraint(equalTo: timeIcon.bottomAnchor, constant: iconDistance),
            provideIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            provideIcon.widthAnchor.constraint(equalToConstant: height),
            provideIcon.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(provideLabel)
        NSLayoutConstraint.activate([
            provideLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: labelDistance),
            provideLabel.leftAnchor.constraint(equalTo: provideIcon.rightAnchor, constant: distance),
            provideLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            provideLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(containsIcon)
        NSLayoutConstraint.activate([
            containsIcon.topAnchor.constraint(equalTo: provideIcon.bottomAnchor, constant: iconDistance),
            containsIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            containsIcon.widthAnchor.constraint(equalToConstant: height),
            containsIcon.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(containsLabel)
        NSLayoutConstraint.activate([
            containsLabel.topAnchor.constraint(equalTo: provideLabel.bottomAnchor, constant: labelDistance),
            containsLabel.leftAnchor.constraint(equalTo: containsIcon.rightAnchor, constant: distance),
            containsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            containsLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(dineInIcon)
        NSLayoutConstraint.activate([
            dineInIcon.topAnchor.constraint(equalTo: containsIcon.bottomAnchor, constant: iconDistance),
            dineInIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            dineInIcon.widthAnchor.constraint(equalToConstant: height),
            dineInIcon.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(dineInLabel)
        NSLayoutConstraint.activate([
            dineInLabel.topAnchor.constraint(equalTo: containsLabel.bottomAnchor, constant: labelDistance),
            dineInLabel.leftAnchor.constraint(equalTo: dineInIcon.rightAnchor, constant: distance),
            dineInLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            dineInLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(topSeperator)
        NSLayoutConstraint.activate([
            topSeperator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            topSeperator.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            topSeperator.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            topSeperator.heightAnchor.constraint(equalToConstant: 0.5)
            ])
    }
}


