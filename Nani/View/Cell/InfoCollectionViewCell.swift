//
//  InfoCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/3/28.
//

import UIKit
import Kingfisher

class InfoCollectionViewCell: UICollectionViewCell {
    
    var infoButtonCallback: (()->())?
    
    var chef: User? {
            didSet {
                nameLabel.text = "By " + chef!.chef_name
                chefLabel.text = chef?.chef_label
                starLabel.text = String(chef!.average_rating) + " (" + String(chef!.total_ratings) + ")"
//                infoButton.setImage(chef?.picture, for: .normal)
                let url = URL(string: chef!.photoURL)
                infoButton.kf.setImage(with: url, for: .normal)
            }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "By Bryten"
        label.font = UIFont(name: "Comfortaa-Bold", size: 16.0)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let chefLabel: UILabel = {
        let label = UILabel()
        label.text = "Super chef"
        label.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let starLabel: UILabel = {
        let label = UILabel()
        label.text = "4.86 (216)"
        label.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var infoButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("View Info", for: UIControl.State.normal)
//        button.showsTouchWhenHighlighted = true
//        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        button.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)\
        button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        let photo = UIImage(named: "Bryten")
        button.setImage(photo, for: .normal)
//        button.addTarget(self, action: #selector(infoButtonTapped), for: UIControl.Event.touchUpInside)
        return button
        }()
    
    let chefIcon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "local_dining-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let starIcon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "star-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var topSeperator: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .lightGray
        return line
    }()
    
    @objc func infoButtonTapped() {
        infoButtonCallback?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        backgroundColor = .white
        let iconSize : CGFloat = 15
        let leading : CGFloat = 15
        let distance : CGFloat = 15
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(chefIcon)
        NSLayoutConstraint.activate([
            chefIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7.5),
            chefIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            chefIcon.widthAnchor.constraint(equalToConstant: iconSize),
            chefIcon.heightAnchor.constraint(equalToConstant: iconSize)
            ])
        addSubview(chefLabel)
        NSLayoutConstraint.activate([
            chefLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            chefLabel.leftAnchor.constraint(equalTo: chefIcon.rightAnchor, constant: 10),
            chefLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            chefLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(starIcon)
        NSLayoutConstraint.activate([
            starIcon.topAnchor.constraint(equalTo: chefIcon.bottomAnchor, constant: 8.5),
            starIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            starIcon.widthAnchor.constraint(equalToConstant: iconSize),
            starIcon.heightAnchor.constraint(equalToConstant: iconSize)
            ])
        addSubview(starLabel)
        NSLayoutConstraint.activate([
            starLabel.topAnchor.constraint(equalTo: chefLabel.bottomAnchor, constant: 5),
            starLabel.leftAnchor.constraint(equalTo: starIcon.rightAnchor, constant: 10),
            starLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            starLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(infoButton)
        NSLayoutConstraint.activate([
            infoButton.centerYAnchor.constraint(equalTo: chefLabel.centerYAnchor, constant: 0),
            infoButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            infoButton.widthAnchor.constraint(equalToConstant: 50),
            infoButton.heightAnchor.constraint(equalToConstant: 50)
            ])
//        addSubview(infoButtonArrow)
//        NSLayoutConstraint.activate([
//            infoButtonArrow.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 25),
//            infoButtonArrow.leftAnchor.constraint(equalTo: infoButton.rightAnchor, constant: 0),
//            infoButtonArrow.widthAnchor.constraint(equalToConstant: 10),
//            infoButtonArrow.heightAnchor.constraint(equalToConstant: 10)
//            ])
        addSubview(topSeperator)
        NSLayoutConstraint.activate([
            topSeperator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            topSeperator.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            topSeperator.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            topSeperator.heightAnchor.constraint(equalToConstant: 0.5)
            ])
    }
}

