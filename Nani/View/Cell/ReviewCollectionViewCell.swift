//
//  ReviewCollectionViewCell.swift
//  Nani
//
//  Created by Jeff on 2021/4/1.
//

import UIKit
import Kingfisher

class ReviewCollectionViewCell: UICollectionViewCell {
    
    var review: Review? {
            didSet {
                reviewLabel.text = review?.comment
                timeLabel.text = review?.posted_time
                starIcon5.image = review!.rating >= 5 ? UIImage(named: "star-24px.emf") : UIImage(named: "star_outline_black_24dp.emf")
                starIcon4.image = review!.rating >= 4 ? UIImage(named: "star-24px.emf") : UIImage(named: "star_outline_black_24dp.emf")
                starIcon3.image = review!.rating >= 3 ? UIImage(named: "star-24px.emf") : UIImage(named: "star_outline_black_24dp.emf")
                starIcon2.image = review!.rating >= 2 ? UIImage(named: "star-24px.emf") : UIImage(named: "star_outline_black_24dp.emf")
                starIcon1.image = review!.rating >= 1 ? UIImage(named: "star-24px.emf") : UIImage(named: "star_outline_black_24dp.emf")
            }
        }
    var user: User?{
        didSet {
            nameLabel.text = user?.chef_name
            let url = URL(string: user!.photoURL)
//            userButton.setImage(user?.picture, for: .normal)
            userButton.kf.setImage(with: url, for: .normal)
        }
    }
    
    var last: Bool?{
        didSet{
            if (last!){
                topSeperator.backgroundColor = .white
            }
            else{
                topSeperator.backgroundColor = .lightGray
            }
        }
    }
    
    
    lazy var userButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("View Info", for: UIControl.State.normal)
//        button.showsTouchWhenHighlighted = true
//        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
//        button.setTitleColor(UIColor.gray, for: UIControl.State.highlighted)\
        button.frame = CGRect(x: 160, y: 100, width: 40, height: 40)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        let photo = UIImage(named: "Photo")
        button.setImage(photo, for: .normal)
//        button.addTarget(self, action: #selector(infoButtonTapped), for: UIControl.Event.touchUpInside)
        return button
        }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Comfortaa-Regular", size: 12)
        label.text = "Justin"
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont(name: "Comfortaa-Regular", size: 12)
        label.text = "March 31, 2021"
        return label
    }()
    
    var reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Comfortaa-Regular", size: 14)
        label.text = "These muffins were really tasty. I baked them just as the recipe said. I used 1 cup of shredded coconut in the batter. I then topped them off with some chopped pecans and more shredded coconut. Yummy!"
        label.numberOfLines = 6
        return label
    }()
    
    
    let starIcon1: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "star-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let starIcon2: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "star-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let starIcon3: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "star-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let starIcon4: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "star-24px.emf").withRenderingMode(.alwaysOriginal))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let starIcon5: UIImageView = {
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
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        let height : CGFloat = 15
        let leading : CGFloat = 15
        let iconDistance : CGFloat = 5
        let labelDistance : CGFloat = 10
        let distance : CGFloat = 15
        let starDistance : CGFloat = 0
        let buttonSize : CGFloat = 40
        backgroundColor = .white
        addSubview(userButton)
        NSLayoutConstraint.activate([
            userButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            userButton.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            userButton.widthAnchor.constraint(equalToConstant: buttonSize),
            userButton.heightAnchor.constraint(equalToConstant: buttonSize)
            ])
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo:topAnchor, constant: 25),
            nameLabel.leftAnchor.constraint(equalTo: userButton.rightAnchor, constant: distance),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(starIcon1)
        NSLayoutConstraint.activate([
            starIcon1.topAnchor.constraint(equalTo: userButton.bottomAnchor, constant: iconDistance),
            starIcon1.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            starIcon1.widthAnchor.constraint(equalToConstant: height),
            starIcon1.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(starIcon2)
        NSLayoutConstraint.activate([
            starIcon2.topAnchor.constraint(equalTo: userButton.bottomAnchor, constant: iconDistance),
            starIcon2.leftAnchor.constraint(equalTo: starIcon1.rightAnchor, constant: starDistance),
            starIcon2.widthAnchor.constraint(equalToConstant: height),
            starIcon2.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(starIcon3)
        NSLayoutConstraint.activate([
            starIcon3.topAnchor.constraint(equalTo: userButton.bottomAnchor, constant: iconDistance),
            starIcon3.leftAnchor.constraint(equalTo: starIcon2.rightAnchor, constant: starDistance),
            starIcon3.widthAnchor.constraint(equalToConstant: height),
            starIcon3.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(starIcon4)
        NSLayoutConstraint.activate([
            starIcon4.topAnchor.constraint(equalTo: userButton.bottomAnchor, constant: iconDistance),
            starIcon4.leftAnchor.constraint(equalTo: starIcon3.rightAnchor, constant: starDistance),
            starIcon4.widthAnchor.constraint(equalToConstant: height),
            starIcon4.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(starIcon5)
        NSLayoutConstraint.activate([
            starIcon5.topAnchor.constraint(equalTo: userButton.bottomAnchor, constant: iconDistance),
            starIcon5.leftAnchor.constraint(equalTo: starIcon4.rightAnchor, constant: starDistance),
            starIcon5.widthAnchor.constraint(equalToConstant: height),
            starIcon5.heightAnchor.constraint(equalToConstant: height)
            ])
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo:starIcon1.bottomAnchor, constant: 5),
            timeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -100),
            timeLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        addSubview(reviewLabel)
        
        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo:timeLabel.bottomAnchor, constant: 5),
            reviewLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: leading),
            reviewLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            reviewLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 90)
            ])
        addSubview(topSeperator)
        NSLayoutConstraint.activate([
            topSeperator.topAnchor.constraint(equalTo:reviewLabel.bottomAnchor, constant: 15),
            topSeperator.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            topSeperator.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            topSeperator.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        
    }
}


